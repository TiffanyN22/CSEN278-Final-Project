class AddCommentTimeToComment < ActiveRecord::Migration[8.1]
  def change
    add_column :comments, :comment_time, :datetime
  end
end
