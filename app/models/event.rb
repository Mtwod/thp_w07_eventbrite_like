class Event < ApplicationRecord
  validates :start_date, 
    presence: true,
    if: -> {self.start_date > Datetime.now, message: "shouldn't start in the past!"}
  
  validates :duration,
    presence: true,
    if: -> {self.duration % 5 == 0, message: 'should be a multiple of 5.'},
    if: -> {self.duration > 0, message: 'should be superior to zero.'}

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
  
  belongs_to :event_admin, class_name: "User"
end
