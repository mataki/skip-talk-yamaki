require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/index.html.erb" do
  include UsersHelper
  
  before(:each) do
    assigns[:users] = [
      stub_model(User,
        :ident_url => "value for ident_url",
        :name => "value for name",
        :display_name => "value for display_name"
      ),
      stub_model(User,
        :ident_url => "value for ident_url",
        :name => "value for name",
        :display_name => "value for display_name"
      )
    ]
  end

  it "should render list of users" do
    render "/users/index.html.erb"
    response.should have_tag("tr>td", "value for ident_url", 2)
    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", "value for display_name", 2)
  end
end

