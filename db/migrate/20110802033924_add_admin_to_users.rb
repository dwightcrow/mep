class AddAdminToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean
    change_column :users, :fb_id, 'bigint'
    change_column :users, :fb_location_id, 'bigint'
  end

  def self.down
  	change_column :users, :fb_location_id, :string, :limit => 21
  	change_column :users, :fb_id, :string, :limit => 21
    remove_column :users, :admin
  end
end
