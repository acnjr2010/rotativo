class AddPerfilIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :perfil_id, :integer
    add_index :users, :perfil_id
  end
end
