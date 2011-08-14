# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

['Running', 'Orgy', 'Hiking', 'Yoga', 'Concert'].each do |name|
  EventType.create(:name => name)
end
  
#create admins
sean = User.new
sean.name = "Sean Holbert"
sean.fb_id = 212696
sean.fb_location_name = "San Francisco, California"
sean.fb_location_id = "114952118516947"
sean.birthday = Date.strptime("09/25/1986", "%m/%d/%Y")
sean.gender = true
sean.pic_url="https://fbcdn-profile-a.akamaihd.net/"+
		"hprofile-ak-snc4/260932_212696_707107_q.jpg"
sean.locked_out = false
sean.admin = true
sean.save

