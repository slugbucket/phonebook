class AddPhonesMobilityPolicy < ActiveRecord::Migration
  def change
    add_column :phones, :mobility_policy_id, :integer, {default: 1, limit: 2, null: false}
  end
end
