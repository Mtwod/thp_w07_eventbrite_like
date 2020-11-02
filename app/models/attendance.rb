class Attendance < ApplicationRecord
  belongs_to :event
  belongs_to :user

  after_create :subscription_send

  def subscription_send
    event = self.event
    attendee = self.user
    event_admin = event.event_admin
    UserMailer.attendee_event_subscription_email(attendee, event).deliver_now
    UserMailer.admin_event_subscription_email(event_admin, event).deliver_now
  end
end
