class UsersController < ApplicationController
  def event_feed
  end
  
  def event_feed_json
    @user = User.new
    render :template => 'users/event_feed.js.erb'
  end
end