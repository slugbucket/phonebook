json.array!(@pin_policies) do |pin_policy|
  json.extract! pin_policy, :id, :name, :description, :policy_type_id, :lync_policy_name
  json.url pin_policy_url(pin_policy, format: :json)
end
