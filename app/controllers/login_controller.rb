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
		
		#Get Name, ID, current location
		userJSON = pull_fb_data("",access_token)
		parsed_json = ActiveSupport::JSON.decode(userJSON)
		p parsed_json["name"]
		p parsed_json["id"]
		p parsed_json["location"]["name"]
		#pull user's picture
		picture = pull_fb_data("/picture",access_token)
		login_user(parsed_json,picture)
	end
	
	def login_user(parsed_json,picture)
		if(user = User.find_by_facebook_id(parsed_json["id"])) then
			user.pic_url = picture
		else
			register_user(parsed_json,picture)
		end
		session[:user_id] = parsed_json["id"]
		session[:user_name] = parsed_json["name"]
		redirect_to "/users/event_feed"
	end
	
	def register_user(parsed_json,picture)
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