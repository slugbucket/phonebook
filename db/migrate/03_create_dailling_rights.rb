class CreateDaillingRights < ActiveRecord::Migration
  def change
    create_table :dialling_rights do |t|
      t.string :name, :null => false, :limit => 32
      t.text :description

      t.timestamps
    end
  end
end
