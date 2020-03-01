class Author < ApplicationRecord
  has_many :books
  validates :terms_of_service, acceptance: { accept: 'yes' }
  validates :eula, acceptance: { accept: ['TRUE', 'accepted'] }
  validates_associated :books
end