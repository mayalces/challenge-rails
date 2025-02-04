require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject { FactoryBot.build(:profile) }

  describe "validations" do
    it { is_expected.to validate_uniqueness_of :username }
    it { is_expected.to allow_value("foo-bar").for(:username) }
    it { is_expected.to_not allow_value("f@@-bar").for(:username) }
  end

  describe "relationships" do
    it { should have_many(:repositories) }
  end
end
