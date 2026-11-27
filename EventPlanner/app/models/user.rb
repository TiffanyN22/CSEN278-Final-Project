class User < ApplicationRecord
  has_secure_password

  has_many :organized_events, class_name: "Event", foreign_key: :organizer_id, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :active_registrations, -> { where(cancelled: [false, nil]) }, class_name: "Registration"
  has_many :comments, dependent: :destroy
  has_many :attended_events, through: :active_registrations, source: :event
end
