class AddCamposToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :vendido_por, :integer
    add_column :orders, :status, :integer
    add_column :orders, :ativado_em, :datetime
  end
end
