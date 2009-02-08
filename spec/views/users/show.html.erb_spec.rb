require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/show.html.erb" do
  include UsersHelper
  
  before(:each) do
    assigns[:user] = @user = stub_model(User,
      :ident_url => "value for ident_url",
      :name => "value for name",
      :display_name => "value for display_name"
    )
  end

  it "should render attributes in <p>" do
    render "/users/show.html.erb"
    response.should have_text(/value\ for\ ident_url/)
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ display_name/)
  end
end

