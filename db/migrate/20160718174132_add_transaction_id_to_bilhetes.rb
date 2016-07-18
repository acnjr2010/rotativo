class AddTransactionIdToBilhetes < ActiveRecord::Migration
  def change
    add_column :bilhetes, :transaction_id, :string
    rename_column :orders, :transation_id, :transaction_id
  end
end
