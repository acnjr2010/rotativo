class CreateVendas < ActiveRecord::Migration
  def change
    create_table :vendas do |t|

      t.timestamps null: false
    end
  end
end
