class ChangeUseridToU64 < ActiveRecord::Migration
  def self.up
    change_column :users, :id, :integer, :length=>8
  end

  def self.down
    change_column :users, :id, :integer
  end
end

