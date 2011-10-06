class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string  :author_name
      t.string  :author_email
      t.integer :user_id
      t.text    :content
      t.integer :commentable_id
      t.timestamps
    end
  end
end
