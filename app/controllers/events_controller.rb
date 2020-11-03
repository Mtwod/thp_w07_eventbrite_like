class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new
    @event.event_admin = current_user

    if @event.save
      redirect_to @event, success: "Cool ! Évènement crée avec succès !!"
    else
      render new_event_path
    end
  end
end
