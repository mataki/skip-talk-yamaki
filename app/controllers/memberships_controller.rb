class MembershipsController < ApplicationController
  before_filter :login_required

  # GET /memberships
  # GET /memberships.xml
  def index
    @memberships = requested_room.memberships

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @memberships }
    end
  end

  # GET /memberships/new
  # GET /memberships/new.xml
  def new
    @membership = requested_room.memberships.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @membership }
    end
  end

  # POST /memberships
  # POST /memberships.xml
  def create
    @membership = requested_room.memberships.build(params[:membership])

    respond_to do |format|
      if @membership.save
        flash[:notice] = 'Membership was successfully created.'
        format.html { redirect_to(room_memberships_url(requested_room)) }
        format.xml  { render :xml => @membership, :status => :created, :location => @membership }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @membership.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.xml
  def destroy
    @membership = requested_room.memberships.find(params[:id])
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to(room_memberships_url(requested_room)) }
      format.xml  { head :ok }
    end
  end
end
