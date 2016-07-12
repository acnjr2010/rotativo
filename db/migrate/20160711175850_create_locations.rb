class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :nome
      t.string :endereco
      t.string :titulo

      t.timestamps null: false
    end
  end
end
