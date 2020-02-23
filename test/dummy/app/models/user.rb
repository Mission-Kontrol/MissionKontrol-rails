class User < ActiveRecord::Base
  has_one :company
end
