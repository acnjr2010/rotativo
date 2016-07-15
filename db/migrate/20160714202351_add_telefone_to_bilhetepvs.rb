class AddTelefoneToBilhetepvs < ActiveRecord::Migration
  def change
    add_column :bilhetepvs, :telefone, :string
  end
end
