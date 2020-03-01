# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :books
  validates :terms_of_service, acceptance: { accept: 'yes' }
  validates :eula, acceptance: { accept: %w[TRUE accepted] }
  validates_associated :books
end
