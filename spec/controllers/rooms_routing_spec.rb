require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RoomsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "rooms", :action => "index").should == "/rooms"
    end

    it "should map #new" do
      route_for(:controller => "rooms", :action => "new").should == "/rooms/new"
    end

    it "should map #show" do
      route_for(:controller => "rooms", :action => "show", :id => 1).should == "/rooms/1"
    end

    it "should map #edit" do
      route_for(:controller => "rooms", :action => "edit", :id => 1).should == "/rooms/1/edit"
    end

    it "should map #update" do
      route_for(:controller => "rooms", :action => "update", :id => 1).should == "/rooms/1"
    end

    it "should map #destroy" do
      route_for(:controller => "rooms", :action => "destroy", :id => 1).should == "/rooms/1"
    end

    it "should map #attendee" do
      route_for(:controller => "rooms", :action => "attendee", :id => 1).should == "/rooms/1/attendee"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/rooms").should == {:controller => "rooms", :action => "index"}
    end

    it "should generate params for #new" do
      params_from(:get, "/rooms/new").should == {:controller => "rooms", :action => "new"}
    end

    it "should generate params for #create" do
      params_from(:post, "/rooms").should == {:controller => "rooms", :action => "create"}
    end

    it "should generate params for #show" do
      params_from(:get, "/rooms/1").should == {:controller => "rooms", :action => "show", :id => "1"}
    end

    it "should generate params for #edit" do
      params_from(:get, "/rooms/1/edit").should == {:controller => "rooms", :action => "edit", :id => "1"}
    end

    it "should generate params for #update" do
      params_from(:put, "/rooms/1").should == {:controller => "rooms", :action => "update", :id => "1"}
    end

    it "should generate params for #destroy" do
      params_from(:delete, "/rooms/1").should == {:controller => "rooms", :action => "destroy", :id => "1"}
    end

    it "should generate params for #attendee" do
      params_from(:get, "/rooms/1/attendee").should == { :controller => "rooms", :action => "attendee", :id => "1"}
    end
  end
end
