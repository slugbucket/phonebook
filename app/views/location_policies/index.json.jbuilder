json.array!(@location_policies) do |location_policy|
  json.extract! location_policy, :id, :name, :description, :policy_type_id, :lync_policy_name
  json.url location_policy_url(location_policy, format: :json)
end
