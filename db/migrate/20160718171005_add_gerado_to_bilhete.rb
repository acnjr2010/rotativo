class AddGeradoToBilhete < ActiveRecord::Migration
  def change
    add_column :bilhetes, :gerado, :boolean, default: true
  end
end
