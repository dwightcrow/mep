require "net/http"
require "uri"
require "net/https"

class LoginController < ApplicationController
  def index
  	@page_title = "Login to hooqup"
  	@maybeSenchaApp="/javascripts/login.js"
  end

	def fb_button_click
		redirect_to "https://www.facebook.com/dialog/oauth?"+
		"client_id="+Rails.application.config.fb_app_id+
		#display=touch makes it look sexy on mobile
		"&display=touch"+
		"&redirect_uri="+Rails.application.config.base_url+"/login/fb_handler"+
		"&scope=email,user_activities,user_interests,user_likes,user_location,user_birthday"
	end

	def fb_handler
		fb_code = params[:code]
		p "code = " + fb_code
		graph_domain = "graph.facebook.com"
		path = "/oauth/access_token?"+
     	"client_id="+Rails.application.config.fb_app_id+
     	"&redirect_uri="+Rails.application.config.base_url+"/login/fb_handler"+
  		"&client_secret="+Rails.application.config.fb_app_secret+
  		"&code="+fb_code
		http = Net::HTTP.new(graph_domain, 443)
		http.use_ssl = true
		res = http.get(path, {})
		access_token = CGI::parse(res.body)["access_token"][0]
		#TODO - theoretically we could also make this call and filter on category for "sports"
		#pull_fb_data ("/likes", access_token)
		login_user(access_token)
	end

	def login_user(access_token)
		#Get Name, ID, current location
		userJSON = pull_fb_data("",access_token)
		parsed_json = ActiveSupport::JSON.decode(userJSON)
		if(user = User.find_by_fb_id(parsed_json["id"])) then
			if not user.locked_out
		    session[:fb_id] = parsed_json["id"]
				session[:user_id] = user.id
				session[:user_name] = parsed_json["name"]
				redirect_to "/users/event_feed"
				return
			end
    else
		  # just put anyone into db for now XXX_DWIGHT
		  register_user( access_token, false )
		  user = User.find_by_fb_id(parsed_json["id"])
		  session[:fb_id] = parsed_json["id"]
		  session[:user_id] = user.id
  		session[:user_name] = parsed_json["name"]
			redirect_to "/users/event_feed"
			return
    end
		session[:access_token] = access_token
		redirect_to "/login/signup"
	end

	#Case where we block the user and
	def signup
		if(!session.has_key?("access_token")) then
  		redirect_to "/login"
  		return
  	end
	end

	#Stores user's data in Signups table and displays "Thank You" message
	def signup_post
		@message = "Thank you!"
		register_user(session[:access_token], true)
		session[:access_token] = nil
	end

	def register_user(access_token, locked_out)
		userJSON = pull_fb_data("",access_token)
		parsed_json = ActiveSupport::JSON.decode(userJSON)
		if(user = User.find_by_fb_id(parsed_json["id"])) then
			@message="You have already signed up."
			return
		end
		picture = pull_fb_data("/picture",access_token)
		user = User.new
		user.admin = false
		user.fb_id = parsed_json["id"]
		user.name = parsed_json["name"]
		user.locked_out = locked_out
		user.pic_url = picture
		user.birthday = Date.parse(parsed_json["birthday"])
		if parsed_json.has_key?("location") then
				user.fb_location_name = parsed_json["location"]["name"]
				user.fb_location_id = parsed_json["location"]["id"]
		end
		if(parsed_json.has_key?("gender")) then
			if parsed_json["gender"].eql?("male") then
				user.gender = true
			else
				user.gender = false
			end
		else
			user.gender = nil
		end
		user.save
	end

	def pull_fb_data(type, access_token)
		graph_domain="graph.facebook.com"
		path = "/me"+type+"?access_token="+access_token
		http = Net::HTTP.new(graph_domain, 443)
		http.use_ssl = true
		res = http.get(path,{})
		#If we're requesting a picture, we want to return the location
		if(type.eql?("/picture")) then return res["location"] end
		return res.body
	end




end

