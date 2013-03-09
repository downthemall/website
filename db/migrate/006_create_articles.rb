class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :category
      t.integer :position
      t.timestamps
    end
    create_table :revisions do |t|
      t.integer :article_id
      t.string  :locale
      t.string  :title
      t.string  :slug
      t.text    :content
      t.boolean :approved
      t.integer :author_id
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
    drop_table :revisions
  end
end
