class CreateSetors < ActiveRecord::Migration
  def change
    create_table :setors do |t|
      t.string :cor
      t.float :preco_periodo

      t.timestamps null: false
    end
  end
end
