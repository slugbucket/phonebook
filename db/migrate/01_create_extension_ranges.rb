class CreateExtensionRanges < ActiveRecord::Migration
  def change
    create_table :extension_ranges do |t|
      t.integer :first_extension, :null => false, :limit => 4
      t.integer :last_extension, :null => false, :limit => 4

      t.timestamps
    end
  end
end
