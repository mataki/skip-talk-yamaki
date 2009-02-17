require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RoomsHelper do
  describe "#show_attendee" do
    it "should return users list html" do
      helper.show_attendee([stub_model(User, :login => "quentin")]).should ==
        "<ul><li>quentin</li></ul>"
    end
  end
end
