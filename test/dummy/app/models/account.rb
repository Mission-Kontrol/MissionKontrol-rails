# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :supplier
  has_one :account_history
end
