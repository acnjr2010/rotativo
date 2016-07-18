class AddTransactionIdFalseToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :transation_id, :string
  end
end
