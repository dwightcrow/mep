# == Schema Information
#
# Table name: events
#
#  id            :integer         not null, primary key
#  event_type_id :integer
#  details       :string(255)
#  start         :datetime
#  end           :datetime
#  location      :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  creator_id    :integer
#

# An event created by a user.
class Event < ActiveRecord::Base
  has_many :users
  has_many :messages
  has_one :event_type
  belongs_to :user, :foreign_key => :creator_id
end

