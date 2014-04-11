class CreateBuildingFloors < ActiveRecord::Migration
  def change
    create_table :building_floors do |t|
      t.string :name

      t.timestamps
    end
  end
end
