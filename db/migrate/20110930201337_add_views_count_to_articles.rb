class AddViewsCountToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :views_count, :integer, :default => 0
  end
end
