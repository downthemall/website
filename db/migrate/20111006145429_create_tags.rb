class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :title
      t.string :slug
      t.timestamps
    end
    create_table :article_tags do |t|
      t.integer :tag_id
      t.integer :article_id
      t.timestamps
    end
  end
end
