# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :author
end
