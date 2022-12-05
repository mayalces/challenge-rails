require 'external/client'

class ReportService
  def generate
    external_client = ::External::Client.new
    profiles = external_client.fetch_profiles
    repositories = external_client.fetch_repositories

    formatted_response(profiles, repositories)
  end

  private

  def formatted_response(ext_profiles, ext_repositories)
    ext_profiles.map do |ext_profile|
      profile = Profile.new(ext_profile)

      repositories = ext_repositories.map do |ext_repository|
        next unless ext_profile['id'] == ext_repository['profile_id']
        Repository.new(ext_repository)
      end.compact

      profile.repositories = repositories
      profile
    end
  end
end
