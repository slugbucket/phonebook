class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name, :null => false, :limit => 32
      t.integer :category_id, :null => false, :limit => 1
      t.string :department_code, :limit => 4, :default => '00'
      t.boolean :active, :default => true
      t.boolean :default_dialling_right_id, :default => 1

      t.timestamps
    end
  end
end
