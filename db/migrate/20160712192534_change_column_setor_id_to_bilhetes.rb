class ChangeColumnSetorIdToBilhetes < ActiveRecord::Migration
  def change
    remove_column :bilhetes, :setor_id
    add_column :bilhetes, :setor_id, :integer
    add_index :bilhetes, :setor_id
  end
end
