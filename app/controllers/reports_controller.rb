class ReportsController < ApplicationController
  def index
    filter =
      if params[:tag].present?
        ActiveRecord::Base.sanitize_sql("%#{params[:tag]}%")
      end

    @profiles = filtered_profiles(filter)

    return_response(@profiles)
  end

  attr_reader :profiles

  private

  def all_profiles
    @profiles = Profile.includes(:repositories)
  end

  def filtered_profiles(filter)
    return all_profiles if filter.blank?

    all_profiles
      .where('LOWER(repositories.tags) LIKE ?', "%#{filter.downcase}%")
      .references(:repositories)
  end

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