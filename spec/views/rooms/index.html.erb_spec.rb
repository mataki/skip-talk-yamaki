require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/rooms/index.html.erb" do
  include RoomsHelper

  before(:each) do
    assigns[:rooms] = [
      stub_model(Room,
        :name => "value for name",
        :display_name => "value for display_name",
        :protect => false
      ),
      stub_model(Room,
        :name => "value for name",
        :display_name => "value for display_name",
        :protect => false
      )
    ]
  end

  it "should render list of rooms" do
    render "/rooms/index.html.erb"
    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", "value for display_name", 2)
    response.should have_tag("tr>td", "false", 2)
  end
end

