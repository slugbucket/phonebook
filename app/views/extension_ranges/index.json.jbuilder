json.array!(@extension_ranges) do |extension_range|
  json.extract! extension_range, :id, :first_extension, :last_extension, :department_id
  json.url extension_range_url(extension_range, format: :json)
end
