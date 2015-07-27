class AddTokenToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :token
    end
    
    add_index :users, :token_id
  end
end
