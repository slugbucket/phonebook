class AddPhonesArchivingPolicy < ActiveRecord::Migration
  def change
    add_column :phones, :archiving_policy_id, :integer, {default: 1, limit: 2, null: false}
  end
end
