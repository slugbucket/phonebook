class CreateRoomStatuses < ActiveRecord::Migration
  def change
    create_table :room_statuses do |t|
      t.string :name, :null => false, :default => 'Public', :limit => 16

      t.timestamps
    end
  end
end
