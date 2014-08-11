class AddSubdeptDefaultArchivingPolicy < ActiveRecord::Migration
  def change
    add_column :sub_departments, :archiving_policy_id, :integer, {default: 1, limit: 2, null: false}
  end
end
