class ChangeUserFbLocationIdToString < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.change :fb_location_id, :string
    end
  end

  def self.down
    change_table :users do |t|
      t.change :fb_location_id, :int
    end
  end
end
