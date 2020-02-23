class Company < ActiveRecord::Base
  belongs_to :user, foreign_key: "owner"

  validates :owner, presence: true
  validate :something, if: :something_else?
end
