json.array!(@external_access_policies) do |external_access_policy|
  json.extract! external_access_policy, :id, :name, :description, :policy_type_id, :lync_policy_name
  json.url external_access_policy_url(external_access_policy, format: :json)
end
