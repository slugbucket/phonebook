class CreateExtensions < ActiveRecord::Migration
  def change
    create_table :extensions  do |t|
      t.integer :extension, :null => false
      t.timestamps
    end
  end
end
