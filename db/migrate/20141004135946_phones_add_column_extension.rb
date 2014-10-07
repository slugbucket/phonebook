class PhonesAddColumnExtension < ActiveRecord::Migration
  def change
    add_column :phones, :ext_number, :string, :limit => 4, :default => 0
  end
end
