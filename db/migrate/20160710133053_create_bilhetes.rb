class CreateBilhetes < ActiveRecord::Migration
  def change
    create_table :bilhetes do |t|
      t.float :preco
      t.text :descricao
      t.string :setor
      t.string :veiculo

      t.timestamps null: false
    end
  end
end
