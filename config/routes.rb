ActionController::Routing::Routes.draw do |map|
  map.resources :rooms, :member => [:attendee] do |room|
    room.resources :memberships, :only => [:index, :new, :create, :destroy]
    room.resources :messages, :only => [:index, :create]
  end

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users

  map.root :controller => "rooms"
  map.resource :session
end
