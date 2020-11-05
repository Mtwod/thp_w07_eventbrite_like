class AttendancesController < ApplicationController
  include AttendancesHelper

  before_action :authenticate_user!
  before_action :find_event
  before_action :amounts

  def new
    can_subscribe?
    event_admin_restrictions
  end
  
  def create
    can_subscribe?
    event_admin_restrictions
    begin
      # Amount in cents

      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })

      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @stripe_amount,
        description: 'Rails Stripe customer',
        currency: 'EUR'
      })

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_event_attendance_path(@event)
    end

    # Attendance.create(user: current_user, event: @event, stripe_customer_id: customer.id) if charge.paid

  end

  def index
    is_event_admin?
  end

end
