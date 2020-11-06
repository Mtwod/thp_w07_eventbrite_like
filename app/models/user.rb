class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "in wrong format" }
  
  # before_create :random_avatar
  after_create :welcome_send

  has_many :admin_events, foreign_key: "event_admin_id", class_name: "Event", dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances, dependent: :destroy
  has_one_attached :avatar

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def random_avatar
    # image = MiniMagick::Image.new('https://picsum.photos/1920/1080')
    # self.avatar.attach(image)
    self.avatar.attach(image_url('yin_yang.png'))
  end
end
