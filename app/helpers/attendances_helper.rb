module AttendancesHelper
  def find_event
    @event = Event.find(params[:event_id])
  end

  def can_subscribe?
    if @event.users.select{ |user| user == current_user }.count == 0
      return true
    else
      redirect_to event_path(@event), warning: "Vous êtes déjà inscrit !"
    end
  end

  def is_event_admin?
    if @event.event_admin == current_user
      return true
    else
      redirect_to event_path(@event), danger: "Vous n'êtes pas le créateur de cette évènement !"
    end
  end

  def event_admin_restrictions
    if @event.event_admin == current_user
      redirect_to event_path(@event), danger: "Vous ne pouvez effectuer cette actions en tant que créateur de cette évènement !"
    end
  end
end
