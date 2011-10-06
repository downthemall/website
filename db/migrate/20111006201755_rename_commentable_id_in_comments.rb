class RenameCommentableIdInComments < ActiveRecord::Migration
  def change
    rename_column :comments, :commentable_id, :article_id
  end
end
