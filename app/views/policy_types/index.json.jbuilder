json.array!(@policy_types) do |policy_type|
  json.extract! policy_type, :id, :name, :description
  json.url policy_type_url(policy_type, format: :json)
end
