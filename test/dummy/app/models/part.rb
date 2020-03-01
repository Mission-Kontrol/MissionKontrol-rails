# frozen_string_literal: true

class Part < ApplicationRecord
  has_and_belongs_to_many :assemblies

  validates :legacy_code, format: { with: /\A[a-zA-Z]+\z/,
                                    message: 'only allows letters' }

  validates :size, inclusion: { in: %w[small medium large],
                                message: '%<value> is not a valid size' }
end
