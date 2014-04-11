class CreateSubDepartments < ActiveRecord::Migration
  def change
    create_table :sub_departments, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 64
      t.integer :department_id, :null => false, :limit => 2
      t.integer :sub_department_code, :null => false, :limit => 2
      t.integer :preferred_extension_range_id

      t.timestamps
    end
  end
end
