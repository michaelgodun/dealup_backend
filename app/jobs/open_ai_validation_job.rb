class OpenAiValidationJob < ApplicationJob
  queue_as :default

  # Retry przy błędzie 429 Too Many Requests
  retry_on Faraday::TooManyRequestsError, wait: :exponentially_longer, attempts: 5

  def perform(deal, model = "gpt-3.5-turbo")
    @deal = deal
    @model = model
    call_openai
  rescue OpenAI::Error => e
    Rails.logger.error "OpenAI API Error for Deal #{@deal.id}: #{e.message}"
    # Opcjonalnie ustaw wynik na FALSE w przypadku błędu
    # @deal.update(validation_result: "FALSE")
  end

  private

  def client_for_model
    case @model
    when "deepseek-chat"
      OpenAI::Client.new(
        access_token: Rails.application.credentials.dig(:deepseek_access_token),
        uri_base: "https://api.deepseek.com/",
        log_errors: true
      )
    else
      OpenAI::Client.new(
        access_token: Rails.application.credentials.dig(:openai_access_token),
        log_errors: true
      )
    end
  end

  def build_messages
    messages = [
      {
        role: "system",
        content: <<~PROMPT
          You are a professional content validator.
          Your task is to check whether the provided text contains:
          - vulgar language
          - illegal or inappropriate links
          
          At the end respond ONLY with uppercase TRUE or FALSE.
          If any inappropriate content is found, respond FALSE.
          If everything is clean, respond TRUE.
        PROMPT
      },
      { role: "user", content: @deal.title.to_s },
      { role: "user", content: @deal.description.to_s }
    ]
    messages << { role: "user", content: @deal.url.to_s } if @deal.url.present?
    messages
  end

  def call_openai
    client = client_for_model
    messages = build_messages
    p "OPEN TOKEN: #{Rails.application.credentials.dig(:deepseek_access_token)}"

    result = nil
    client.chat(
      parameters: {
        model: @model,
        messages: messages,
        temperature: 0
      }
    ).then do |resp|
      result = resp.dig("choices", 0, "message", "content")&.strip
    end

    Rails.logger.info "Validation result for Deal #{@deal.id}: #{result}"

    # Opcjonalnie zapis do kolumny
    # @deal.update(validation_result: result)
  end
end
