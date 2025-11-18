class Api::V1::Admin::ExportsController < Api::V1::Admin::BaseController
  def show
    export = current_user.exports.find(params[:id])


    download_url =
      if export.finished? && export.file.attached?
        path = Rails.application.routes.url_helpers.rails_blob_path(export.file, only_path: true)
        "#{Rails.application.routes.default_url_options[:host]}#{path}"
      end

    render json: {
      id: export.id,
      status: export.status,
      format: export.format,
      download_url: download_url
    }
  end
end
