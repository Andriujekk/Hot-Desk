class Desk < ApplicationRecord
    belongs_to :user, optional: true

    def booked_by?(user)
        self.user == user
      end
    
      def toggle_booking(user)
        if booked_by?(user)
          self.user = nil
        else
          self.user = user
        end
        save
      end
end
