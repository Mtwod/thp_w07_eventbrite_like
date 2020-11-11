module ApplicationHelper
  def bootstrap_class_for_flash(type)
    case type
      when 'notice' then "info"
      when 'error' then "danger"
      when 'alert' then "warning"
      else type
    end
  end

  def amounts
    @amount = @event.price
    @stripe_amount = @amount * 100
  end
end
