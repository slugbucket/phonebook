class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name, :null => false, :default => 'Building name', :limit => 64

      t.timestamps
    end
  end
end
