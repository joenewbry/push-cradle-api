class AddIdfaStringToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :idfa, :string
  end
end
