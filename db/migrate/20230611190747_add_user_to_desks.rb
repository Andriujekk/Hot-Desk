class AddUserToDesks < ActiveRecord::Migration[7.0]
  def change
    add_reference :desks, :user, foreign_key: true
  end
end
