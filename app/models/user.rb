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

# A user; nuff said.
class User < ActiveRecord::Base
  has_many :events
  has_many :messages
  attr_accessible :facebook_id

  def relevant_events
    Event.all
  end

  def event_feed_json
    relevant_events.map do |event|
      {
        :eventId => event.id,
        :creatorId => event.creator.facebook_id,
        :participants => event.participants.map { |user| { :userId => user.facebook_id, :name => user.name, :pic => user.pic_url } },
        :type => event.event_type_id,
        :details => event.details,
        :startTime => event.start_time,
        :endTime => event.end_time,
        :location => event.location,
        :messages => event.messages.map { |message| { :message => message.text, :messageId => message.id, :fromUserId => message.from_user.facebook_id, :sentAt => message.created_at } }
      }
    end.to_json
  end
end

