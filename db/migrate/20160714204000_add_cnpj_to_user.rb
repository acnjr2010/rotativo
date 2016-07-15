class AddCnpjToUser < ActiveRecord::Migration
  def change
    add_column :users, :cnpj, :string
  end
end
