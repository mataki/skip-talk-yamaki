class RoomsController < ApplicationController
  before_filter :login_required

  include RoomsHelper

  # GET /rooms
  # GET /rooms.xml
  def index
    @rooms = Room.accessible(current_user)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rooms }
    end
  end

  # GET /rooms/1
  # GET /rooms/1.xml
  def show
    @room = Room.accessible(current_user).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @room }
    end
  end

  # GET /rooms/new
  # GET /rooms/new.xml
  def new
    @room = Room.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @room }
    end
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.accessible(current_user).find(params[:id])
  end

  # POST /rooms
  # POST /rooms.xml
  def create
    @room = Room.new(params[:room])
    @room.memberships.build(:user => current_user)

    respond_to do |format|
      if @room.save
        flash[:notice] = 'Room was successfully created.'
        format.html { redirect_to(@room) }
        format.xml  { render :xml => @room, :status => :created, :location => @room }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @room.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.xml
  def update
    @room = Room.accessible(current_user).find(params[:id])

    respond_to do |format|
      if @room.update_attributes(params[:room])
        flash[:notice] = 'Room was successfully updated.'
        format.html { redirect_to(@room) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @room.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.xml
  def destroy
    @room = Room.accessible(current_user).find(params[:id])
    @room.destroy

    respond_to do |format|
      format.html { redirect_to(rooms_url) }
      format.xml  { head :ok }
    end
  end

  def attendee
    @room = Room.accessible(current_user).find(params[:id])
    update_attendee_box @room
    render :nothing => true
  end

  def leave
    @room = Room.accessible(current_user).find(params[:id])
    current_user.leave([@room.id])
    update_attendee_box @room
    redirect_to room_url(@room)
  end

  protected
  def update_attendee_box(room)
    render :juggernaut => { :type => :send_to_channel, :channel => [room.id] } do |page|
      page["div#attendee"].html show_attendee(room.attendee)
    end
  end
end
