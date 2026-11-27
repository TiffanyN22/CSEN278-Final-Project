class Event < ApplicationRecord
  belongs_to :organizer, class_name: "User"
  belongs_to :category, optional: true
  has_many :registrations, dependent: :destroy
  has_many :comments, dependent: :destroy
end
