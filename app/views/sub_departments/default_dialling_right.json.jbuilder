json.array! @dept do |dr|
  json.extract! dr, :id, :name
end
