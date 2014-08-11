class CreateMobilityPolicies < ActiveRecord::Migration
  def change
    create_table :mobility_policies do |t|
      t.string :name, :null => false, :unique => true, :limit => 255, :default => "Global"
      t.text :description
      t.integer :policy_type_id, :null => false, :limit => 2, :default => 9
      t.string :lync_policy_name, :null => false, :limit => 255, :default => "Global"

      t.timestamps
    end
  end
end
