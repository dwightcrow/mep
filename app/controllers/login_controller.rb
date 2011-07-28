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

	end
	
	def pull_fb_data(type, access_token)
		graph_domain="graph.facebook.com"
		path = "/me"+type+"?access_token="+access_token
		http = Net::HTTP.new(graph_domain, 443)
		http.use_ssl = true
		res = http.get(path, nil)
		return res.body
	end
end
