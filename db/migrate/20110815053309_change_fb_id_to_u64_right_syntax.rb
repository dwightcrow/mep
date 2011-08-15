class ChangeFbIdToU64RightSyntax < ActiveRecord::Migration
  def self.up
    change_column :users, :fb_id, :integer, :limit=>8
  end

  def self.down
    change_column :users, :fb_id, :integer
  end
end

