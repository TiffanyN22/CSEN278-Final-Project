class User < ApplicationRecord
  has_secure_password

  has_many :organized_events, class_name: "Event", foreign_key: :organizer_id, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :comments, dependent: :destroy
end
