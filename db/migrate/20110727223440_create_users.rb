class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :facebookId
      t.string :name
      t.string :picUrl

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
