module RoomsHelper
    def desks_in_room(room)
        @desks.select do |desk|
            desk_in_room?(desk, room)
        end
    end
    
    def desk_in_room?(desk, room)
        desk.pos_x >= room.top_left_x && desk.pos_x < room.top_left_x + room.width &&
        desk.pos_y >= room.top_left_y && desk.pos_y < room.top_left_y + room.height
    end

    def any_desk_booked?(room)
        desks = desks_in_room(room)
        desks.any? { |desk| desk.user_id? }
    end
        
end
