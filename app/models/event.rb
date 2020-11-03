class Event < ApplicationRecord
  validates :start_date, 
    presence: true
  
  validates :duration,
    presence: true,
    numericality: { greater_than: 0 }

  validates :title,
    presence: true,
    length: { in: 5..140, message: ": Le nombre de caractère doit être compris entre 5 et 140" }
    
  validates :description,
    presence: true,
    length: { in: 20..1000, message: ": Le nombre de caractère doit être compris entre 20 et 1000"}

  validates :price,
    presence: true,
    numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000, only_integer: true }

  validates :location, presence: true

  validate :start_before_now?,
    :multiple_of_five?
  
  belongs_to :event_admin, class_name: "User"
  has_many :attendances
  has_many :users, through: :attendances
 
  def start_before_now?
    unless start_date == nil || start_date > DateTime.now
      errors.add(:expiration_date, "ne peut être dans le passé")
    end
  end
 
  def multiple_of_five?
    unless duration == nil || duration % 5 == 0
      errors.add(:discount, "doit être un multiple de 5.") unless duration % 5 == 0
    end
  end

  def end_date
    self.start_date + (self.duration * 60)
  end
end