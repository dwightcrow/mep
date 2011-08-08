class EventsController < ApplicationController
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

  def newFromApp
    @event = Event.new
    @event_types = EventType.all.map { |et| [et.name, et.id] }


  end



end

