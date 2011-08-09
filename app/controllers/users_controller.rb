class UsersController < ApplicationController
  def event_feed
  	if(!session.has_key?("user_id")) then
  		redirect_to "/login"
  		return
  	end
  	u = User.find_by_fb_id(session[:user_id])
  	if u.admin  then
  		@admin_priv = '<center><a a href="/users/admin?select=all">Admin</a></center>'.html_safe
  	end
  	@page_title = "Welcome to Hooqup"
  end

  def logout
		session[:user_id]=nil
		session[:user_name]=nil
		redirect_to "/login"
	end
	
	def admin
		u = User.find_by_fb_id(session[:user_id])
		if u==nil or !u.admin 
			redirect "/users/event_feed"
			return
		end
		@fb_profile_base = "http://www.facebook.com/profile.php?"
		@cond =""
		#HACK OF A FILTER FUNCTION - TODO
		if not params.has_key?(:select) then
			#Filters:
			if params.has_key?(:gender) then
				if params[:gender]=="male"  then @cond+="sex='t'"
				elsif params[:gender]=="female" then @cond+="sex='f'" end
			end
			if params.has_key?(:accepted)  then
				if(not @cond.empty?) then @cond+=" AND " end
				accept = (not params[:accepted].eql?("true")).to_s
				p accept
				@cond+="locked_out='"+accept[0,1]+"'"
			end
		end
	end

  def event_feed_json
    @user = User.new
    render :template => 'users/event_feed.js.erb'
  end
end

