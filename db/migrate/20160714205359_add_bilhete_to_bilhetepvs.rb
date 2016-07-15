class AddBilheteToBilhetepvs < ActiveRecord::Migration
  def change
    add_column :bilhetepvs, :bilhete, :string
  end
end
