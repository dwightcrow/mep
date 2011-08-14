class EventsController < ApplicationController

	def index
		@maybeSenchaApp="/javascripts/event_feed.js"
	end

  def new
    @event = Event.new
    @event_types = EventType.all.map { |et| [et.name, et.id] }

    num_days = 3
    @start_days = num_days.times.map do |day_offset|
      dt = DateTime.now.advance(:days => day_offset)
      { :label => dt.strftime("%a")[0..1], :date => dt.to_s }
    end
    @end_days = num_days.times.map do |day_offset|
      dt = DateTime.now.advance(:days => day_offset)
      { :label => dt.strftime("%a")[0..1], :date => dt.to_s }
    end

    @start_times = 24.times.map do |hour|
      [sprintf("%02d:00", hour), sprintf("%02d:00", hour)]
    end
    @end_times = 24.times.map do |hour|
      [sprintf("%02d:00", hour), sprintf("%02d:00", hour)]
    end
  end

  def saveEvent
    puts 'start'
    e = Event.new
    e.event_type_id = params[:event_type_id]
    e.details = params[:details]
    e.start_time =  Time.parse( params[:start_time] )
    e.end_time = Time.parse( params[:end_time] )
    e.location = params[:location]
    e.creator_id = session[:user_id]
    e.save
    ep = e.event_participants.create()
    ep.user_id = session[:user_id]
    ep.save
    e.save
    redirect_to '/events/new'
  end

  def get_events
    @events = Event.all
    render :json => "[#{@events.map(&:to_json).join(',')}]"
  end

  def add_participant
    e = Event.find( params[:event_id])
    ep = e.event_participants.create()
    ep.user_id = session[:user_id]
    ep.save
    redirect_to '/events/new'
  end

end

