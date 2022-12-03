require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'validations' do
    subject { FactoryBot.build(:profile) }
    it { is_expected.to validate_uniqueness_of :username }
  end
end