class Company < ActiveRecord::Base
  belongs_to :user, foreign_key: "owner"
end
