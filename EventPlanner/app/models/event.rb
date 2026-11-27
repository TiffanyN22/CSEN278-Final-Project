class Event < ApplicationRecord
  belongs_to :organizer, class_name: "User"
  belongs_to :category, optional: true
  has_many :registrations, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :preview_img

  scope :upcoming, -> { where("date >= ?", Time.current).order(date: :asc) }
  scope :past, -> { where("date < ?", Time.current).order(date: :desc) }
end
