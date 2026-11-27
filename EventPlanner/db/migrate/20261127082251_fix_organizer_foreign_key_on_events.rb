class FixOrganizerForeignKeyOnEvents < ActiveRecord::Migration[8.1]
  def change
    remove_foreign_key :events, :user
    add_foreign_key :events, :users, column: :organizer_id
  end
end
