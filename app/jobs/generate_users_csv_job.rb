require "csv"

class GenerateUsersCsvJob < ApplicationJob
  queue_as :default

  def perform(export_id)
    export = Export.find(export_id)

    export.update!(status: "processing")

    users = User.all

    csv_string = CSV.generate(headers: true) do |csv|
      csv << ['ID', 'Username', 'Email', 'Status', 'Created At']
      users.each do |user|
        csv << [user.id, user.username, user.email, user.status, user.created_at]
      end
    end

    export.file.attach(
      io: StringIO.new(csv_string),
      filename: "users.csv",
      content_type: "text/csv"
    )

    export.update!(status: "finished")
  rescue => e
    export.update!(status: "failed")
    raise e
  end
end
