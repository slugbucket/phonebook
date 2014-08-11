class DropTableDiallingRights < ActiveRecord::Migration
  def change
    drop_table :dialling_rights
  end
end
