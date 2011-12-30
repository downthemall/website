class AddSessionIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :session_id, :string
  end
end
