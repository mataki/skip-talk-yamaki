require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RoomsController do
  fixtures :users

  before do
    login_as(:quentin)
  end

  def mock_room(stubs={})
    @mock_room ||= mock_model(Room, stubs)
  end

  describe "responding to GET index" do

    it "should expose all rooms as @rooms" do
      Room.should_receive(:find).with(:all).and_return([mock_room])
      get :index
      assigns[:rooms].should == [mock_room]
    end

    describe "with mime type of xml" do

      it "should render all rooms as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Room.should_receive(:find).with(:all).and_return(rooms = mock("Array of Rooms"))
        rooms.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end

    end

  end

  describe "responding to GET show" do

    it "should expose the requested room as @room" do
      Room.should_receive(:find).with("37").and_return(mock_room)
      get :show, :id => "37"
      assigns[:room].should equal(mock_room)
    end

    describe "with mime type of xml" do

      it "should render the requested room as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Room.should_receive(:find).with("37").and_return(mock_room)
        mock_room.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end

  end

  describe "responding to GET new" do

    it "should expose a new room as @room" do
      Room.should_receive(:new).and_return(mock_room)
      get :new
      assigns[:room].should equal(mock_room)
    end

  end

  describe "responding to GET edit" do

    it "should expose the requested room as @room" do
      Room.should_receive(:find).with("37").and_return(mock_room)
      get :edit, :id => "37"
      assigns[:room].should equal(mock_room)
    end

  end

  describe "responding to POST create" do
    before do
      Room.stub!(:new).and_return(mock_room)
      mock_room.stub!(:memberships).and_return(@memberships = mock('memberships'))
      @memberships.stub!(:build).and_return(stub_model(Membership))
    end
    describe "with valid params" do
      before do
        mock_room.stub!(:save).and_return(true)
      end
      it "should expose a newly created room as @room" do
        Room.should_receive(:new).with({'these' => 'params'}).and_return(mock_room)
        post :create, :room => {:these => 'params'}
        assigns(:room).should equal(mock_room)
      end

      it "should redirect to the created room" do
        post :create, :room => {}
        response.should redirect_to(room_url(mock_room))
      end

    end

    describe "with invalid params" do
      before do
        mock_room.stub!(:save).and_return(false)
      end
      it "should expose a newly created but unsaved room as @room" do
        post :create, :room => {:these => 'params'}
        assigns(:room).should equal(mock_room)
      end

      it "should re-render the 'new' template" do
        post :create, :room => {}
        response.should render_template('new')
      end

    end

  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested room" do
        Room.should_receive(:find).with("37").and_return(mock_room)
        mock_room.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :room => {:these => 'params'}
      end

      it "should expose the requested room as @room" do
        Room.stub!(:find).and_return(mock_room(:update_attributes => true))
        put :update, :id => "1"
        assigns(:room).should equal(mock_room)
      end

      it "should redirect to the room" do
        Room.stub!(:find).and_return(mock_room(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(room_url(mock_room))
      end

    end

    describe "with invalid params" do

      it "should update the requested room" do
        Room.should_receive(:find).with("37").and_return(mock_room)
        mock_room.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :room => {:these => 'params'}
      end

      it "should expose the room as @room" do
        Room.stub!(:find).and_return(mock_room(:update_attributes => false))
        put :update, :id => "1"
        assigns(:room).should equal(mock_room)
      end

      it "should re-render the 'edit' template" do
        Room.stub!(:find).and_return(mock_room(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested room" do
      Room.should_receive(:find).with("37").and_return(mock_room)
      mock_room.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "should redirect to the rooms list" do
      Room.stub!(:find).and_return(mock_room(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(rooms_url)
    end

  end

  describe "responding to GET attendee" do
    it "should render juggeranut update attendee box" do
      Room.should_receive(:find).with("37").and_return(mock_room)
      mock_room.should_receive(:attendee).and_return([mock_model(User, :login => "quentin")])
      controller.should_receive(:render).with(:juggernaut => { :type => :send_to_channel, :channel => [mock_room.id] }).and_yield({"div#attendee" => page_selector = mock("page_selector")})
      page_selector.should_receive(:html).with(/quentin/)
      controller.stub!(:render)
      get :attendee, :id => "37"
    end
  end

  describe "responding to GET leave" do
    before do
      Room.should_receive(:find).with("37").and_return(mock_room)
      current_user.stub!(:leave).with([mock_room.id])
      controller.stub!(:update_attendee_box).with(mock_room)
    end
    it "should redirect_to room's show" do
      get :leave, :id => "37"
      response.should redirect_to(room_url(mock_room))
    end
    it "should leave juggeranut channel" do
      current_user.should_receive(:leave).with([mock_room.id])
      get :leave, :id => "37"
    end
    it "should update attedee list to user who is in this channel" do
      controller.should_receive(:update_attendee_box).with(mock_room)
      get :leave, :id => "37"
    end
    def current_user
      controller.send(:current_user)
    end
  end
end
