require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByCookieToken

  has_many :memberships

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_uniqueness_of   :openid_identifier
  validates_presence_of     :openid_identifier

  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :openid_identifier

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def leave(room_ids)
    room_ids = [room_ids] unless room_ids.is_a?(Array)
    Juggernaut.remove_channels_from_clients [self.id], room_ids
  end
end
