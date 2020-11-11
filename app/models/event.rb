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
    :multiple_of_five?,
    :has_picture?
  
  belongs_to :event_admin, class_name: "User"
  has_many :attendances
  has_many :users, through: :attendances
  has_one_attached :event_picture
 
  def start_before_now?
    unless start_date == nil || start_date > DateTime.now
      errors.add(:start_date, "ne peut être dans le passé")
    end
  end
 
  def multiple_of_five?
    unless duration == nil || duration % 5 == 0 || start_date == nil
      errors.add(:discount, "doit être un multiple de 5.")
    end
  end

  def end_date
    self.start_date + (self.duration * 60)
  end

  # To use later !!
  def is_free?
    return self.price == 0
  end

  def has_picture?
    unless self.event_picture.attached?
      errors.add(:event_picture, "Vous devez ajouter une photo !")
    end
  end

  # by Vanak
  def get_start
    self.start_date.strftime('%Y-%m-%d %H:%M')
  end

  def end_event
    date = self.start_date.to_datetime + (self.duration/1440.0)
    date.strftime('%H:%M')
  end
end