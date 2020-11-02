class Event < ApplicationRecord
  validates :start_date, 
    presence: true
  
  validates :duration,
    presence: true,
    numericality: { greater_than: 0 }

  validates :title,
    presence: true,
    length: { in: 5..140, message: ": The number of characters must be between 5 and 140" }
    
  validates :description,
    presence: true,
    length: { in: 20..1000, message: ": The number of characters must be between 20 and 1000"}

  validates :description,
    presence: true,
    length: { in: 1..1000, message: ": The price must be between 1 and 1000"}

  validates :location, presence: true

  validate :start_before_now?,
    :multiple_of_five?
  
  belongs_to :event_admin, class_name: "User"
 
  def start_before_now?
    errors.add(:expiration_date, "can't be in the past.") if start_date < Date.today
  end
 
  def multiple_of_five?
    errors.add(:discount, "should be a multiple of 5.") unless duration % 5 == 0
  end
end