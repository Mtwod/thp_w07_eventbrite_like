class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "in wrong format" }
  
  after_create :welcome_send

  has_many :admin_events, foreign_key: "event_admin_id", class_name: "Event", dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances, dependent: :destroy

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
