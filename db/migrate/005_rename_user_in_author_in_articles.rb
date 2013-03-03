class RenameUserInAuthorInArticles < ActiveRecord::Migration
  def self.up
    rename_column :articles, :user_id, :author_id
  end

  def self.down
    rename_column :articles, :author_id, :user_id
  end
end
