class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :event_type_id
      t.string :details
      t.datetime :start
      t.datetime :end
      t.string :location

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
