class Category < ApplicationRecord
  has_many :event, dependent: :nullify
end
