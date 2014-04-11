json.array!(@phones) do |phone|
  json.extract! phone, :id, :firstname, :surname, :uid, :sub_department_id
  json.url phone_url(phone, format: :json)
end
