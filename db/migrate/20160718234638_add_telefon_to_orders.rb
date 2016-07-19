class AddTelefonToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :telefone, :string
  end
end
