class UsersController < ApplicationController
  def event_feed
  	if(!session.has_key?("user_id")) then
  		redirect_to "/login"
  		return
  	end
  	u = User.find_by_fb_id(session[:user_id])
  	if u.admin  then
  		@admin_priv = '<center><a href="/users/admin">Admin</a></center>'.html_safe
  	end
  	@page_title = "Welcome to Hooqup"
  end

  def logout
		session[:user_id]=nil
		session[:user_name]=nil
		redirect_to "/login"
	end
	
	def admin
		@fb_profile_base = "http://www.facebook.com/profile.php?"
	end

  def event_feed_json
    @user = User.new
    render :template => 'users/event_feed.js.erb'
  end
end

