class EventSubmissionsController < Admin::BaseController
  before_action :event_submissions, :event_to_submit

  def index
  end

  def show
    
  end

  def edit
    
  end

  def update
    
  end

  private

  def event_submissions
    @events_to submit = []
    Events.all.each do |event|
      @events << event if event.validated == false 
    end
  end

  def event_to_submit
    @event_to_submit = Event.find(params[:id])
  end
end