class AddCnpjToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :cnpj, :string
  end
end
