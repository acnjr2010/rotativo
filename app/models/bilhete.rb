class Bilhete < ActiveRecord::Base
  has_many :vendas
  belongs_to :user
  belongs_to :veiculo

  options = {
    credentials: PagSeguro::ApplicationCredentials.new("nog.junior84@gmail.com", "AC95709BEB6C47D68C80DE2E01ED9D60"),
    permissions: [:searches, :notifications],
    notification_url: "localhost:3000/notification",
    redirect_url: 'bar.com.br'
  }
  byebug
  response = PagSeguro::Authorization.new(options).authorize
end
