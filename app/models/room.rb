class Room < ActiveRecord::Base
  has_many :memberships
  has_many :messages

  def attendee
    clients_ids = Juggernaut.show_clients_for_channels(self.id).map{|c| c["id"]}
    clients_ids.blank? ? [] : User.find(clients_ids)
  end
end
