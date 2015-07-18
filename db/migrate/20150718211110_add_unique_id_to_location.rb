class AddUniqueIdToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :unique_id, :string
  end
end
