json.array!(@departments) do |department|
  json.extract! department, :id, :name, :category_id, :default_dialling_right, :active
  json.url department_url(department, format: :json)
end
