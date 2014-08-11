class AddPhonesConferencePolicy < ActiveRecord::Migration
  def change
    add_column :phones, :conferencing_policy_id, :integer, {default: 1, limit: 2, null: false}
  end
end
