class User < ApplicationRecord
    has_one :desk
    has_one :room
end
