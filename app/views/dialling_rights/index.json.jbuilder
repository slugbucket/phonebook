json.array!(@dialling_rights) do |dialling_right|
  json.extract! dialling_right, :id, :name, :description
  json.url dialling_right_url(dialling_right, format: :json)
end
