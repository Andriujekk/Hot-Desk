class ChangeRoomsStructure < ActiveRecord::Migration[7.0]
  def change
    change_table :rooms do |t|
      t.remove :lu, :ld, :ru, :rd
      t.integer :top_left_x
      t.integer :top_left_y
      t.integer :width
      t.integer :height
    end
  end
end
