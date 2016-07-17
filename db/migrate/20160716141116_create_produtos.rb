class CreateProdutos < ActiveRecord::Migration
  def change
    create_table :produtos do |t|
      t.text :description
      t.decimal :price

      t.timestamps null: false
    end
  end
end
