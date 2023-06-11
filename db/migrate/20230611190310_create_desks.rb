class CreateDesks < ActiveRecord::Migration[7.0]
  def change
    create_table :desks do |t|
      t.integer :floor_number
      t.integer :pos_x
      t.integer :pos_y
      t.string :booked_by

      t.timestamps
    end
  end
end
