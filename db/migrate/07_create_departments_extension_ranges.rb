class CreateDepartmentExtensionRanges < ActiveRecord::Migration
  def change
    create_table :department_extension_ranges, :id => false do |t|
      t.integer :department_id, :null => false, :limit => 4
      t.integer :extension_range_id, :null => false, :limit => 4
    end
  end
end
