# == Schema Information
#
# Table name: event_participants
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  event_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

# This is the link that indicates a user is interested in an event.
class EventParticipant < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
end

