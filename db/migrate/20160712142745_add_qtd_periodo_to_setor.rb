class AddQtdPeriodoToSetor < ActiveRecord::Migration
  def change
    add_column :setors, :qtd_periodo, :integer
  end
end
