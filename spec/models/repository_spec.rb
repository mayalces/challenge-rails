require 'rails_helper'

RSpec.describe Repository, type: :model do
  subject { FactoryBot.build(:repository) }

  describe "relationships" do
    it { should belong_to(:profile) }
  end
end