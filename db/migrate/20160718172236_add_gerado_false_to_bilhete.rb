class AddGeradoFalseToBilhete < ActiveRecord::Migration
  def change
    remove_column :bilhetes, :gerado
    add_column :bilhetes, :gerado, :boolean, default: false
  end
end
