json.array!(@rooms) do |room|
  json.extract! room, :id, :name, :public_name, :room_status_id, :building_id, :building_floor_id
  json.url room_url(room, format: :json)
end
