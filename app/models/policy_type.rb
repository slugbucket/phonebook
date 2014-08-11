class PolicyType < ActiveRecord::Base
  belongs_to :archiving_policy
  belongs_to :client_policy
  belongs_to :client_version_policy
  belongs_to :conference_policy
  belongs_to :dial_plan_policy
  belongs_to :external_access_policy
  belongs_to :location_policy
  belongs_to :mobility_policy
  belongs_to :persist_chat_policy
  belongs_to :pin_policy
  belongs_to :voice_policy
  
end
