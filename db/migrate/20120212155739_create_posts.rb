class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :author
      t.datetime :posted_at
      t.boolean :public

      t.timestamps
    end
  end
end
