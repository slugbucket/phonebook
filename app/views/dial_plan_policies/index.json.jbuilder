json.array!(@dial_plan_policies) do |dial_plan_policy|
  json.extract! dial_plan_policy, :id, :name, :description, :policy_type, :lync_policy_name
  json.url dial_plan_policy_url(dial_plan_policy, format: :json)
end
