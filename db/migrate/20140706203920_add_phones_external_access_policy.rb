class AddPhonesExternalAccessPolicy < ActiveRecord::Migration
  def change
    add_column :phones, :external_access_policy_id, :integer, {default: 1, limit: 2, null: false}
  end
end
