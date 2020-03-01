class Company < ActiveRecord::Base
  belongs_to :user, foreign_key: "owner"

  validates :owner, presence: true
  validate :something, if: :something_else?
  validates :subdomain, exclusion: { in: %w(www us ca jp),
    message: "%{value} is reserved." }
end
