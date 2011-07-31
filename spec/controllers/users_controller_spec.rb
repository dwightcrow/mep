require "spec_helper"

describe UsersController do
  describe :event_feed do
    it "should work" do
      get :event_feed
      response.should be_success
    end
  end
end