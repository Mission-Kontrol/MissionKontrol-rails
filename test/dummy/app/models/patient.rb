class Patient < ApplicationRecord
  has_many :appointments
  has_many :physicians, through: :appointments

  validates :email, confirmation: true
  validates :email_confirmation, presence: true
end