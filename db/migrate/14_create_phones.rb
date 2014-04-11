class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :firstname, :null => false, :limit => 32
      t.string :surname, :null => false, :limit => 32
      t.string :uid, :null => false, :limit => 32
      t.integer :room_id
      t.integer :sub_department_id
      t.integer :extension_id
      t.integer :dialling_right_id

      t.timestamps
    end
  end
end
