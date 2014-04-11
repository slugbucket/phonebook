json.array!(@sub_departments) do |sub_department|
  json.extract! sub_department, :id, :name, :department_id, :first_extension, :last_extension
  json.url sub_department_url(sub_department, format: :json)
end
