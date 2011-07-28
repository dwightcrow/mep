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
end
