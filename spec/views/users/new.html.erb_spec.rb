require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/new.html.erb" do
  include UsersHelper
  
  before(:each) do
    assigns[:user] = stub_model(User,
      :new_record? => true,
      :ident_url => "value for ident_url",
      :name => "value for name",
      :display_name => "value for display_name"
    )
  end

  it "should render new form" do
    render "/users/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", users_path) do
      with_tag("input#user_ident_url[name=?]", "user[ident_url]")
      with_tag("input#user_name[name=?]", "user[name]")
      with_tag("input#user_display_name[name=?]", "user[display_name]")
    end
  end
end


