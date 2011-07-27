# == Schema Information
#
# Table name: event_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Type of an event, such as "running", "yoga", "orgy", ...
class EventType < ActiveRecord::Base
  belongs_to :event
end

