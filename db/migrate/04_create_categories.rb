class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :null => false, :limit => 10, :default => "Staff"

      t.timestamps
    end
  end
end
