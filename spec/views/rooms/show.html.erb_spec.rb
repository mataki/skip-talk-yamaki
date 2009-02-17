require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/rooms/show.html.erb" do
  include RoomsHelper
  
  before(:each) do
    assigns[:room] = @room = stub_model(Room,
      :name => "value for name",
      :display_name => "value for display_name",
      :protect => false
    )
  end

  it "should render attributes in <p>" do
    render "/rooms/show.html.erb"
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ display_name/)
    response.should have_text(/als/)
  end
end

