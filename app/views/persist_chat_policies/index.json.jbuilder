json.array!(@persist_chat_policies) do |persist_chat_policy|
  json.extract! persist_chat_policy, :id, :name, :description, :policy_type_id, :lync_policy_name
  json.url persist_chat_policy_url(persist_chat_policy, format: :json)
end
