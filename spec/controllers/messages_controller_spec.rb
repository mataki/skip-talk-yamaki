require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MessagesController do
  describe "POST /messages" do
    describe "succsess creating" do
      it "massage should be saved" do
        lambda do
          post :create, :message => { :content => "コンテンツ" }
        end.should change(Message, :count)
      end
      it "render juggernaut prepend content" do
        controller.should_receive(:render_for_juggernaut)
        post :create, :message => { :content => "コンテンツ" }
      end
    end
  end
end
