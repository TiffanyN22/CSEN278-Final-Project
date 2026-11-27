json.extract! event, :id, :name, :description, :date, :location, :preview_img, :organizer_id, :category_id, :created_at, :updated_at
json.url event_url(event, format: :json)
