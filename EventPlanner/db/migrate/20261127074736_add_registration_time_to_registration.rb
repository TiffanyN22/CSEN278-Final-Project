class AddRegistrationTimeToRegistration < ActiveRecord::Migration[8.1]
  def change
    add_column :registrations, :registration_time, :datetime
  end
end
