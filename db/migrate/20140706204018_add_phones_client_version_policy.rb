class AddPhonesClientVersionPolicy < ActiveRecord::Migration
  def change
    add_column :phones, :client_version_policy_id, :integer, {default: 1, limit: 2, null: false}
  end
end
