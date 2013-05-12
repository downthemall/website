class RenameUserInAuthorInPosts < ActiveRecord::Migration
  def self.up
    rename_column :posts, :user_id, :author_id
  end

  def self.down
    rename_column :posts, :author_id, :user_id
  end
end

