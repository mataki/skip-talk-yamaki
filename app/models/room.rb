class Room < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :messages

  def attendee
    clients_ids = Juggernaut.show_clients_for_channels(self.id).map{|c| c["id"]}
    clients_ids.blank? ? [] : User.find(clients_ids)
  end

  named_scope :accessible, proc { |user|
    { :conditions => ["(rooms.protect = :false) or (rooms.protect = :true and memberships.user_id IN (:user_ids))", { :false => false, :true => true, :user_ids => [user.id] }],
      :include => :memberships }
  }
end
