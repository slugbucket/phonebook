class AddSubdeptDefaultDialPlanPolicy < ActiveRecord::Migration
  def change
    add_column :sub_departments, :dial_plan_policy_id, :integer, {default: 1, limit: 2, null: false}
  end
end
