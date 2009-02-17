require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MessagesController do
  fixtures :users, :rooms
  before do
    login_as('quentin')
  end
  describe "POST /messages" do
    describe "succsess creating" do
      it "massage should be saved" do
        lambda do
          post_create
        end.should change(Message, :count)
      end
      it "render juggernaut prepend content" do
        controller.should_receive(:render).with(:juggernaut => { :type => :send_to_channel, :channel => [rooms(:one).id] }).and_yield({"ul#messages" => page_selector = mock("page_id")})
        page_selector.should_receive(:prepend).with("<li>quentin: コンテンツ</li>")
        controller.stub!(:render)
        post_create
      end
    end
    describe "fail creating" do
      before do
        message = stub_model(Message)
        message.stub!(:save).and_return(false)
        Message.stub!(:new).and_return(message)
      end
      it "render juggernaut alert message" do
        controller.should_receive(:render).with(:juggernaut => { :type => :send_to_client, :client_id => users(:quentin).id }).and_yield(page = mock('page'))
        page.should_receive(:alert).with(/not saved/)
        controller.stub!(:render)
        post_create
      end
    end
    def post_create
      post :create, :message => { :content => "コンテンツ" }, :room_id => rooms(:one)
    end
  end
end
