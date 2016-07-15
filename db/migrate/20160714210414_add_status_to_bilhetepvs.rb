class AddStatusToBilhetepvs < ActiveRecord::Migration
  def change
    add_column :bilhetepvs, :status, :integer
  end
end
