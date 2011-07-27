class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :text
      t.integer :from_user_id
      t.integer :event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
