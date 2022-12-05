class ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def new
    @profile = Profile.new
    @profile.repositories.build
  end

  def create
    @profile = Profile.new(profile_params)

    if @profile.save
      respond_to do |format|
        format.html { redirect_to reports_path, notice: "Profile Created!" }
      end
    else
      @errors = @profile.errors.full_messages
      respond_to do |format|
        format.html { render(:new, status: :unprocessable_entity) }
      end
    end
  end

  def profile_params
    params.require(:profile)
      .permit(:username, repositories_attributes: %w[name tags])
  end
end
