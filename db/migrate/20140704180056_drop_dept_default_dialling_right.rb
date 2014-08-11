class DropDeptDefaultDiallingRight < ActiveRecord::Migration
  def change
    remove_column :departments, :default_dialling_right_id
  end
end
