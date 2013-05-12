class CreateDonations < ActiveRecord::Migration
  def self.up
    create_table :donations do |t|
      t.string  :donor_name
      t.float   :amount
      t.string  :transaction_id
      t.string  :status
      t.string  :currency
      t.boolean :public
      t.text    :fail_reason
      t.timestamps
    end
  end

  def self.down
    drop_table :donations
  end
end

