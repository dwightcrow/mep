class MessagesController < ApplicationController
  def create
    event = Event.find(params[:event_id])

    message = Message.new
    message.text = params[:text]
    message.from_user_id = session[:user_id]
    message.event_id = event.id
    message.save
    # add the msg user to participants for now, else breaks pic/user_id code
    alreadyHere = false
    for x in event.participants
      if x.id == session[:user_id]
        alreadyHere = true
      end
    end
    if !alreadyHere
      ep = event.event_participants.create()
      ep.user_id = session[:user_id]
      ep.save
    end
    redirect_to '/users/event_feed'
  end
end

