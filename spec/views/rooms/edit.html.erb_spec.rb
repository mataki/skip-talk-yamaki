require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/rooms/edit.html.erb" do
  include RoomsHelper
  
  before(:each) do
    assigns[:room] = @room = stub_model(Room,
      :new_record? => false,
      :name => "value for name",
      :display_name => "value for display_name",
      :protect => false
    )
  end

  it "should render edit form" do
    render "/rooms/edit.html.erb"
    
    response.should have_tag("form[action=#{room_path(@room)}][method=post]") do
      with_tag('input#room_name[name=?]', "room[name]")
      with_tag('input#room_display_name[name=?]', "room[display_name]")
      with_tag('input#room_protect[name=?]', "room[protect]")
    end
  end
end


