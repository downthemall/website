class AddPublicToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :public, :boolean
  end
end
