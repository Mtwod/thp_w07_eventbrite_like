class EventsController < Admin::BaseController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.event_admin = current_user
    
    if @event.save
      redirect_to @event, success: "Cool ! Évènement crée avec succès !!"
    else
      render new_event_path
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event, success: "Votre évènement a été édité avec succès !"
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id]).destroy
    redirect_to root_path, success: "L'évènement a été supprimé avec succès, \n reviens quand tu veux pour en créer un autre !"
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location, :event_picture)
  end

  def is_event_admin?
    @event = Event.find(params[:id])
    unless is_author?(@event.event_admin)
      redirect_to @event, danger: "Vous n'êtes pas le créateur de cet évènement !!"
    end
  end
end
