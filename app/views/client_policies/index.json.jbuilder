json.array!(@client_policies) do |client_policy|
  json.extract! client_policy, :id, :name, :description, :policy_type_id, :lync_policy_name
  json.url client_policy_url(client_policy, format: :json)
end
