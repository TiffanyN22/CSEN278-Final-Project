class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  # scope uniqueness so users can re-register for events they cancelled
  validates :user_id, uniqueness: {
    scope: :event_id,
    conditions: -> { where(cancelled: [false, nil]) },
    message: "is already registered for this event"
  }
end
