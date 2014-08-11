class AddSubdeptDefaultExternalAccessPolicy < ActiveRecord::Migration
  def change
    add_column :sub_departments, :external_access_policy_id, :integer, {default: 1, limit: 2, null: false}
  end
end
