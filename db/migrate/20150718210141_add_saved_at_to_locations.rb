class AddSavedAtToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :saved_at, :date
  end
end
