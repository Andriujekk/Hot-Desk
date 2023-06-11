json.extract! room, :id, :floor_number, :lu, :ld, :ru, :rd, :booked_by, :created_at, :updated_at
json.url room_url(room, format: :json)
