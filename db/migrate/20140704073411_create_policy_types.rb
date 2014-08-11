class CreatePolicyTypes < ActiveRecord::Migration
  def change
    create_table :policy_types do |t|
      t.string :name, :null => false, :unique => true, :limit => 255, :default => "Policy type"
      t.text :description

      t.timestamps
    end
  end
end
