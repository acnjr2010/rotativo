class AddTiposPerfis < ActiveRecord::Migration
  def self.up
    tipos = ["Admin", "Prefeitura", "Fiscais", "PontoVendas", "Usuario"]
    tipos.each do |tipo|
      execute("insert into perfis(tipo) values('#{tipo}')")
    end
  end

  def self.down
    tipos = [1, 2, 3, 4, 5]
    tipos.each do |tipo|
      execute("delete * from perfis where id = #{tipo}")
    end
  end
end
