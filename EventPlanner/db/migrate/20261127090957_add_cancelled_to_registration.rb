class AddCancelledToRegistration < ActiveRecord::Migration[8.1]
  def change
    add_column :registrations, :cancelled, :boolean, default:0
  end
end
