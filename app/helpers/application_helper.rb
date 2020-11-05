module ApplicationHelper
  def amounts
    @amount = @event.price
    @stripe_amount = @amount * 100
  end
end
