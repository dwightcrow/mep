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
end

