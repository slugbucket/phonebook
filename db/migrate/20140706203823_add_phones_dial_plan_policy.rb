class AddPhonesDialPlanPolicy < ActiveRecord::Migration
  def change
    add_column :phones, :dial_plan_policy_id, :integer, {default: 1, limit: 2, null: false}
  end
end
