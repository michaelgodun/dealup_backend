require "csv"
class GenerateDealsCsvJob < ApplicationJob
  queue_as :default

  def perform(export_id)
    export = Export.find(export_id)

    export.update!(status: "processing")

    deals = Deal.all

    csv_string = CSV.generate(headers: true) do |csv|
      csv << ['ID', 'Title', 'Price', 'Created At']
      deals.each do |deal|
        csv << [deal.id, deal.title, deal.price, deal.created_at]
      end
    end


    export.file.attach(
      io: StringIO.new(csv_string),
      filename: "deals.csv",
      content_type: "text/csv"
    )


    export.update!(status: "finished")
  rescue => e
    export.update!(status: "failed")
    raise e
  end
end
