json.array!(@voice_policies) do |voice_policy|
  json.extract! voice_policy, :id, :name, :description, :policy_type_id, :lync_policy_name
  json.url voice_policy_url(voice_policy, format: :json)
end
