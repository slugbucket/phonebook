json.array!(@mobility_policies) do |mobility_policy|
  json.extract! mobility_policy, :id, :name, :description, :policy_type_id, :lync_policy_name
  json.url mobility_policy_url(mobility_policy, format: :json)
end
