class AddSubdeptDefaultClientVersionPolicy < ActiveRecord::Migration
  def change
    add_column :sub_departments, :client_version_policy_id, :integer, {default: 1, limit: 2, null: false}
  end
end
