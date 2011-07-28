# == Schema Information
#
# Table name: messages
#
#  id           :integer         not null, primary key
#  text         :string(255)
#  from_user_id :integer
#  event_id     :integer
#  created_at   :datetime
#  updated_at   :datetime
#

# A message a user wrote on an event.
class Message < ActiveRecord::Base
  belongs_to :event
end

