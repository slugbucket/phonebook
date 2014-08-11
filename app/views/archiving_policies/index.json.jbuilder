json.array!(@archiving_policies) do |archiving_policy|
  json.extract! archiving_policy, :id, :name, :description, :policy_type_id, :lync_policy_name
  json.url archiving_policy_url(archiving_policy, format: :json)
end
