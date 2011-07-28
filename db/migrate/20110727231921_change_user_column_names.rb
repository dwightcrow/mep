class ChangeUserColumnNames < ActiveRecord::Migration
  def self.up
    rename_column :users, :facebookId, :facebook_id
    rename_column :users, :picUrl, :pic_url
  end

  def self.down
    rename_column :users, :facebook_id, :facebookId
    rename_column :users, :pic_url, :picUrl
  end
end
