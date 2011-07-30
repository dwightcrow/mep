require "spec_helper"

describe EventsController do
  describe :new do
    it "should work" do
      get :new
      response.should be_success
    end
  end
end