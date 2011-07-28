# == Schema Information
#
# Table name: users
#
#  id          :integer         not null, primary key
#  facebook_id :integer
#  name        :string(255)
#  pic_url     :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'


describe User do
  describe :event_feed do
    it "should do stuff" do
      creator = Factory.create(:user)
      Factory.create(:event, :creator_id => creator.facebook_id)
      
      user1 = Factory.create(:user)
      user2 = Factory.create(:user)
      
      p creator.event_feed_json
    end
    
    it "dummy" do
      mason = Factory.create(:user, :name => "Mason Simon", :facebook_id => 1, :pic_url => "https://encrypted-tbn3.google.com/images?q=tbn:ANd9GcQunmaNuxGPq7Z3NNkaeYvtNviM3m6UvE-w0vKnuRdswlh0PuMu")
      sean = Factory.create(:user, :name => "Sean Holbert", :facebook_id => 2, :pic_url => "https://encrypted-tbn3.google.com/images?q=tbn:ANd9GcTxQ0tPZkHRHar3zmvcEByhdEhN5oz15qkux-xOYskA226Y8l5odg")
      ashwin = Factory.create(:user, :name => "Ashwin Mudaliar", :facebook_id => 3, :pic_url => "https://encrypted-tbn2.google.com/images?q=tbn:ANd9GcTOugRH2peeiRniAvvZGBDG2MEjfJD54TVGFAByO-RqEdZi3pXgIA")
      dwight = Factory.create(:user, :name => "Dwight Crow", :facebook_id => 4, :pic_url => "https://encrypted-tbn2.google.com/images?q=tbn:ANd9GcQ4jaEFxaxiDdA57OSYgWbhq5ugZTOXELcoKnv6W_KP-xQ5d6zt")
      
      # This first one is an event you created, and you're the only one going.
      e1 = Factory.create(:event, :creator_id => mason.facebook_id, :event_type_id => 1, :details => "~5miler in the Presidio", :location => "somewhere in sf", :start_time => DateTime.now.advance(:hours => 3), :end_time => DateTime.now.advance(:hours => 5))
      Factory.create(:event_participant, :event_id => e1.id, :user_id => mason.id)
      Factory.create(:message, :text => "yo anyone coming to this?", :from_user_id => mason.facebook_id)
      
      # Here's another one you created, with a couple people going.
      e2 = Factory.create(:event, :creator_id => mason.facebook_id, :event_type_id => 2, :details => "you down for downward dog, dawg?", :location => "the mission", :start_time => DateTime.now.advance(:hours => 27), :end_time => DateTime.now.advance(:hours => 30))
      Factory.create(:event_participant, :event_id => e2.id, :user_id => mason.id)
      Factory.create(:event_participant, :event_id => e2.id, :user_id => sean.id)
      Factory.create(:message, :text => "i'm so tight right now", :from_user_id => sean.facebook_id)
      Factory.create(:message, :text => "6p at Mission Cliffs work?", :from_user_id => mason.facebook_id)
      Factory.create(:message, :text => "yea", :from_user_id => sean.facebook_id)
      Factory.create(:message, :text => "NAMASTE BITCHES", :from_user_id => mason.facebook_id)

      # Here's an event someone else made, that no one else is going to.
      e3 = Factory.create(:event, :creator_id => ashwin.facebook_id, :event_type_id => 1, :details => "short and hard", :location => "around Noe Valley", :start_time => DateTime.now.advance(:hours => 40), :end_time => DateTime.now.advance(:hours => 44))
      Factory.create(:event_participant, :event_id => e3.id, :user_id => ashwin.id)

      # Here's an event someone else made, that a few people (not including you) are going to.
      e4 = Factory.create(:event, :creator_id => dwight.facebook_id, :event_type_id => 3, :details => "let's get high: climb the TransAm building", :location => "FiDi", :start_time => DateTime.now.advance(:hours => 60), :end_time => DateTime.now.advance(:hours => 69))
      Factory.create(:event_participant, :event_id => e4.id, :user_id => sean.id)
      Factory.create(:event_participant, :event_id => e4.id, :user_id => ashwin.id)
      Factory.create(:event_participant, :event_id => e4.id, :user_id => dwight.id)
      Factory.create(:message, :text => "how bout at 2pm?", :from_user_id => sean.facebook_id)
      Factory.create(:message, :text => "can't do 2. 3 works tho", :from_user_id => dwight.facebook_id)
      Factory.create(:message, :text => "i can do 3", :from_user_id => sean.facebook_id)
      Factory.create(:message, :text => "me 2", :from_user_id => ashwin.facebook_id)
      Factory.create(:message, :text => "done. 3pm in front of the TransAm building", :from_user_id => dwight.facebook_id)
      
      puts mason.event_feed_json
    end
  end
end