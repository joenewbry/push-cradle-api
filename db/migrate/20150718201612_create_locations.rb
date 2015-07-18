class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.date :created_at
      t.float :latitude
      t.float :longitude
      t.boolean :saved
      t.string :my_id
      t.string :device_id

      t.timestamps null: false
    end
  end
end
