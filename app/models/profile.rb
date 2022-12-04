class Profile < ApplicationRecord
  has_many :repositories, inverse_of: :profile
  accepts_nested_attributes_for :repositories

  validates :username, presence: true, uniqueness: true
  validates :username, format: { with: /\A[a-zA-Z0-9-]+\z/,
    message: "only allows alphanumeric characters and hyphens (-)" }
end
