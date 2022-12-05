class ReportFilterer
  def all_profiles
    Profile.includes(:repositories)
  end

  def filtered_profiles(filter)
    return all_profiles if filter.blank?

    all_profiles
      .where('LOWER(repositories.tags) LIKE ?', "%#{filter.downcase}%")
      .references(:repositories)
  end
end