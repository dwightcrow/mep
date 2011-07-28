class UsersController < ApplicationController
  def event_feed
  	if(!session.has_key?("user_id")) then 
  		redirect_to "/login" 
  		return
  	end
  	@page_title = "Welcome to Hooqup " + session[:user_name].split(" ")[0] + "!"
  end
  
  def logout
		session[:user_id]=nil
		session[:user_name]=nil
		redirect_to "/login"
	end
	
  def event_feed_json
    @user = User.new
    render :template => 'users/event_feed.js.erb'
  end
end