class CreateClientPolicies < ActiveRecord::Migration
  def change
    create_table :client_policies do |t|
      t.string :name, :null => false, :limit => 255, :default => "Global"
            t.text :description
            t.integer :policy_type_id, :null => false, :limit => 2, :default => 11
            t.string :lync_policy_name, :null => false, :limit => 255, :default => "Global"

      t.timestamps
    end
  end
end
