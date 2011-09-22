class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :ancestry
      t.integer :ancestry_depth, :default => 0
      t.boolean :sticky
      t.timestamps
    end
    add_index :articles, :ancestry
  end
end
