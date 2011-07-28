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

require 'spec_helper'

describe Message do
  pending "add some examples to (or delete) #{__FILE__}"
end

