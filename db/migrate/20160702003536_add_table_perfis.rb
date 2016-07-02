class AddTablePerfis < ActiveRecord::Migration
  def self.up
    create_table :perfis do |t|
      t.string :tipo
    end
  end

  def self.down
    drop_table :perfis
  end

end
