class AddSessionsTable < ActiveRecord::Migration
  def change
    create_table :phonebook_sessions do |t|
      t.string :session_id, :null => false
      t.text :phonebook_session_data
      t.timestamps
    end

    add_index :phonebook_sessions, :session_id, :unique => true
    add_index :phonebook_sessions, :updated_at
  end
end
