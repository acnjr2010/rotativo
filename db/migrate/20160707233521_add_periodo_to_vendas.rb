class AddPeriodoToVendas < ActiveRecord::Migration
  def change
    add_column :vendas, :periodo, :string
  end
end
