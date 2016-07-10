class AddPeriodoToBilhetes < ActiveRecord::Migration
  def change
    add_column :bilhetes, :periodo, :integer
  end
end
