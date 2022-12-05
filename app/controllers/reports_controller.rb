class ReportsController < ApplicationController
  def index
    filter =
      if params[:tag].present?
        ActiveRecord::Base.sanitize_sql("%#{params[:tag]}%")
      end

    @profiles = ReportFilterer.new.filtered_profiles(filter)

    return_response(@profiles)
  end

  def external
    @profiles = ReportService.new.generate

    return_response(@profiles)
  end

  private

  def return_response(profiles)
    respond_to do |format|
      format.html
      format.json {
        render json: profiles.to_json(
          only: :username,
          include: {
            repositories: {
              only: %w[id name tags profile_id]
            }
          }
        )
      }
    end
  end
end