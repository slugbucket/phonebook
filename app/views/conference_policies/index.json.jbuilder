json.array!(@conference_policies) do |conference_policy|
  json.extract! conference_policy, :id, :name, :description, :policy_type_id, :lync_policy_name
  json.url conference_policy_url(conference_policy, format: :json)
end
