class CreateImageAssets < ActiveRecord::Migration
  def self.up
    create_table :image_assets do |t|
      t.attachment :image
      t.timestamps
    end
  end

  def self.down
    drop_table :image_assets
  end
end
