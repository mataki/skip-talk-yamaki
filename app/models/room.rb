class Room < ActiveRecord::Base
  has_many :memberships
  has_many :messages
end
