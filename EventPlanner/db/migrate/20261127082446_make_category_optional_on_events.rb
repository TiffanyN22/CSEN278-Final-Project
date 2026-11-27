class MakeCategoryOptionalOnEvents < ActiveRecord::Migration[8.1]
  def change
    change_column_null :events, :category_id, true
  end
end
