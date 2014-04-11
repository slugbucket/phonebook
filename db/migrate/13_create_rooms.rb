class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name, :null => false, :limit => 32, :default => "LBS room"
      t.string :public_name, :null => false, :limit => 32, :default => "Public room name"
      t.integer :room_status_id, :null => false, :default => 1
      t.integer :building_id, :null => false
      t.integer :building_floor_id, :null => false, :default => 1

      t.timestamps
    end
  end
end
