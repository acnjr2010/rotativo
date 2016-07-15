class AddPeriodoToBilhetepvs < ActiveRecord::Migration
  def change
    add_column :bilhetepvs, :periodo, :integer
  end
end
