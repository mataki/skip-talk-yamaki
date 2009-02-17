require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Room do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :display_name => "value for display_name",
      :protect => false
    }
  end

  it "should create a new instance given valid attributes" do
    Room.create!(@valid_attributes)
  end

  describe "named_scope accessible" do
    before do
      [User, Membership, Room].map(&:delete_all)
      @a_user = User.create!(:login => "a_user", :openid_identifier => "identifier")
      @b_user = User.create!(:login => "b_user", :openid_identifier => "openid")
      @a_room = Room.create!(:name => "a_room", :protect => true)
      @b_room = Room.create!(:name => "b_room", :protect => false)
      Membership.create!(:user => @a_user, :room => @a_room)
    end
    it "a_user should find a_room" do
      Room.accessible(@a_user).should be_include(@a_room)
    end
    it "a_user should find b_room" do
      Room.accessible(@a_user).should be_include(@b_room)
    end
    it "b_user should not find a_room" do
      Room.accessible(@b_user).should_not be_include(@a_room)
    end
    it "b_user should find b_room" do
      Room.accessible(@b_user).should be_include(@b_room)
    end
  end
end
