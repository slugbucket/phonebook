class AddSubdeptDefaultClientPolicy < ActiveRecord::Migration
  def change
    add_column :sub_departments, :client_policy_id, :integer, {default: 1, limit: 2, null: false}
  end
end
