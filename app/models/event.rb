# == Schema Information
#
# Table name: events
#
#  id            :integer         not null, primary key
#  event_type_id :integer
#  details       :string(255)
#  start_time    :datetime
#  end_time      :datetime
#  location      :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  creator_id    :integer
#

# An event created by a user.
class Event < ActiveRecord::Base
  has_many :event_participants
  has_many :users, :through => :event_participants
  has_many :messages
  has_one :event_type
  belongs_to :user, :foreign_key => :creator_id

  def participants
    self.users
  end

  def creator
    self.user
  end

  def to_json
    myHash = {
    :eventId => self.id,
    :creatorId => self.creator_id,
    :participants => self.event_participants.includes(:user).map { |ep| { :userId => ep.user_id, :name => User.find_by_fb_id(ep.user_id).name, :pic => User.find_by_fb_id(ep.user_id).pic_url } },
    :type => self.event_type_id,
    :details => self.details,
    :startTime => self.start_time,
    :endTime => self.end_time,
    :location => self.location,
    :messages => self.messages.map { |message| { :message => message.text, :messageId => message.id, :fromUserId => message.from_user.fb_id, :sentAt => message.created_at } }
    }
    myHash.to_json
  end

end

