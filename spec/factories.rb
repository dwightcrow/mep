FactoryGirl.define do
  factory :user do
    facebook_id 1234567890
    name "John Doe"
    pic_url "https://encrypted-tbn2.google.com/images?q=tbn:ANd9GcQ4jaEFxaxiDdA57OSYgWbhq5ugZTOXELcoKnv6W_KP-xQ5d6zt"
  end
  
  factory :event do
    details "quick 5 mile run"
    association :event_type, :factory => :event_type
    start_time { DateTime.now }
    end_time { DateTime.now.advance(:hours => 2) }
    location "somewhere in SF"
    association :creator, :factory => :user
  end
  
  factory :event_participant do
    association :user, :factory => :user
    association :event, :factory => :event
  end
  
  factory :event_type do
    name "running"
  end
  
  factory :message do
    text "let's meet at 5pm; that work?"
    association :from_user_id, :factory => :user
    association :event, :factory => :event
  end
end