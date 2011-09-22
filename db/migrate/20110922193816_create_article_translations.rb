class CreateArticleTranslations < ActiveRecord::Migration
  def change
    create_table :article_translations do |t|
      t.references :article, :null => false
      t.string :locale, :length => 2, :null => false
      t.string :title
      t.text :content
      t.text :excerpt
      t.string :slug, :null => false
      t.timestamps
    end
    add_index :article_translations, :article_id
    add_index :article_translations, :slug
  end
end
