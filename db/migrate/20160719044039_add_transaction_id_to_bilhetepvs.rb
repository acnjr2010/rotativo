class AddTransactionIdToBilhetepvs < ActiveRecord::Migration
  def change
    add_column :bilhetepvs, :transaction_id, :string
  end
end
