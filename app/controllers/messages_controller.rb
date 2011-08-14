class MessagesController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    
    message = Message.new
    message.text = params[:text]
    message.from_user_id = session[:user_id]
    message.event_id = event.id
    message.save
    redirect_to '/users/event_feed'
  end
end