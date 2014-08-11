class AddSubdeptDefaultConferencePolicy < ActiveRecord::Migration
  def change
    add_column :sub_departments, :conferencing_policy_id, :integer, {default: 1, limit: 2, null: false}
  end
end
