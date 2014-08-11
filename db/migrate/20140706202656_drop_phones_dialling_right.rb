class DropPhonesDiallingRight < ActiveRecord::Migration
  def change
    remove_column :phones, :dialling_right_id
  end
end
