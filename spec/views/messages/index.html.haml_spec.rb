require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/messages/index" do
  describe "なにもメッセージがない場合" do
    before(:each) do
      assigns[:messages] = []
      render 'messages/index'
    end

    it "should tell you where to find the file" do
      response.should have_tag('ul')
    end
  end
  describe "メッセージが存在する場合" do
    before(:each) do
      template.stub!(:show_message).and_return("<li>コンテンツ</li>")
      assigns[:messages] = [@message = stub_model(Message, :content => "コンテンツ")]
      render 'messages/index'
    end

    it "should tell you where to find the file" do
      response.should have_tag('ul') do
        with_tag('li', /コンテンツ/)
      end
    end
    it "should call show_message" do
      template.should_receive(:show_message).with(@message)
    end
  end
end
