class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "in wrong format" }

  has_many :admin_events, foreign_key: "event_admin_id", class_name: "Attendance", dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances, dependent: :destroy
end
