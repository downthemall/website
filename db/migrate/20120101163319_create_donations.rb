class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :user_id
      t.float   :amount
      t.string  :donor_name
      t.boolean :test
      t.string  :status
      t.string  :payment_method
      t.string  :transaction_id
      t.string  :description
      t.timestamps
    end
  end
end
