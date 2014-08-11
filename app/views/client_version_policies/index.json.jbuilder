json.array!(@client_version_policies) do |client_version_policy|
  json.extract! client_version_policy, :id, :name, :description, :policy_type_id, :lync_policy_name
  json.url client_version_policy_url(client_version_policy, format: :json)
end
