class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :fb_id
      t.string :name
      t.string :fb_location_name
      t.string :fb_location_id
      t.date 	 :birthday
      t.boolean :gender
      t.string :pic_url
      t.boolean :locked_out
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
