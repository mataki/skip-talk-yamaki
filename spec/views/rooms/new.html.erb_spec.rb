require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/rooms/new.html.erb" do
  include RoomsHelper
  
  before(:each) do
    assigns[:room] = stub_model(Room,
      :new_record? => true,
      :name => "value for name",
      :display_name => "value for display_name",
      :protect => false
    )
  end

  it "should render new form" do
    render "/rooms/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", rooms_path) do
      with_tag("input#room_name[name=?]", "room[name]")
      with_tag("input#room_display_name[name=?]", "room[display_name]")
      with_tag("input#room_protect[name=?]", "room[protect]")
    end
  end
end


