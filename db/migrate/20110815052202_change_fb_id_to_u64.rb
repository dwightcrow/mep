class ChangeFbIdToU64 < ActiveRecord::Migration
  def self.up
    change_column :users, :fb_id, :integer, :length=>8
  end

  def self.down
    change_column :users, :fb_id, :integer
  end
end

