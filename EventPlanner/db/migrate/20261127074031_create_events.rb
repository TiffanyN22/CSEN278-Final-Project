class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.datetime :date, null: false
      t.string :location, null: false
      t.string :preview_img
      t.references :organizer, null: false, foreign_key: {to_table: :user}
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
