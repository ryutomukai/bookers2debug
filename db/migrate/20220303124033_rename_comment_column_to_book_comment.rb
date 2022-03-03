class RenameCommentColumnToBookComment < ActiveRecord::Migration[6.1]
  def change
    rename_column :book_comments, :Comment, :comment
  end
end
