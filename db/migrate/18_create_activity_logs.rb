class CreateActivityLogs < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.string :item_type, :limit => 64, :null => false, :default => 'Object'
      t.integer :item_id, :null => false
      t.string :act_action, :default => 'update'
      t.string :updated_by, :limit => 32, :default => 'Anonymous'
      t.text :activity
      t.datetime :act_tstamp, :default => Time.now
    end
  end
end
