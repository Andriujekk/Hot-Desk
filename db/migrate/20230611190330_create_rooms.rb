class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.integer :floor_number
      t.integer :lu
      t.integer :ld
      t.integer :ru
      t.integer :rd
      t.string :booked_by

      t.timestamps
    end
  end
end
