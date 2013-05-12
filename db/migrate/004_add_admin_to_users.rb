class AddAdminToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.boolean :admin
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :admin
    end
  end
end

