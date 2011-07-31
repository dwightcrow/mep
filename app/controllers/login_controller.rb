require "net/http"
require "uri"
require "net/https"

class LoginController < ApplicationController
  def index
  	@page_title = "Login to hooqup"
  end

	def fb_button_click
		redirect_to "https://www.facebook.com/dialog/oauth?"+
		"client_id="+Rails.application.config.fb_app_id+
		"&redirect_uri="+Rails.application.config.base_url+"/login/fb_handler"+
		"&scope=email,user_activities,user_interests,user_likes,user_location"
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
		res = http.get(path, nil)
		access_token = CGI::parse(res.body)["access_token"][0]
		#TODO - theoretically we could also make this call and filter on category for "sports"
		#pull_fb_data ("/likes", access_token)
		login_user(access_token)
	end
	
	def login_user(access_token)
		#Get Name, ID, current location
		userJSON = pull_fb_data("",access_token)
		parsed_json = ActiveSupport::JSON.decode(userJSON)
		if(user = User.find_by_facebook_id(parsed_json["id"])) then
			#pull user's picture
			picture = pull_fb_data("/picture",access_token)
			user.pic_url = picture
			session[:user_id] = parsed_json["id"]
			session[:user_name] = parsed_json["name"]
			redirect_to "/users/event_feed"
		else
				session[:access_token] = access_token
				redirect_to "/login/signup"
				return
		end
	end
	
	#Case where we block the user and 
	def signup
		#if(!session.has_key?("user_id")) then 
  	#	redirect_to "/login" 
  #		return
  	#end
		userJSON = pull_fb_data("",session[:access_token])
		parsed_json = ActiveSupport::JSON.decode(userJSON)
	end
	
	def register_user(access_token)
		#Get Name, ID, current location
		userJSON = pull_fb_data("",access_token)
		parsed_json = ActiveSupport::JSON.decode(userJSON)
		picture = pull_fb_data("/picture",access_token)
		user = User.new
		user.facebook_id = parsed_json["id"]
		user.name = parsed_json["name"]
		user.created_at = Time.now.utc
		user.updated_at = Time.now.utc
		user.pic_url = picture
	end
	
	def pull_fb_data(type, access_token)
		graph_domain="graph.facebook.com"
		path = "/me"+type+"?access_token="+access_token
		http = Net::HTTP.new(graph_domain, 443)
		http.use_ssl = true
		res = http.get(path, nil)
		#If we're requesting a picture, we want to return the location
		if(type.eql?("/picture")) then return res["location"] end
		return res.body
	end
	
	
	
	
end