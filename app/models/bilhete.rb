class Bilhete < ActiveRecord::Base
  belongs_to :user
  belongs_to :veiculo

  validates :placa_veiculo, :user_id, presence: true

    # options = {
  #   credentials: PagSeguro::ApplicationCredentials.new("nog.junior84@gmail.com", "AC95709BEB6C47D68C80DE2E01ED9D60"),
  #   permissions: [:searches, :notifications],
  #   #notification_url: "localhost:3000/notification",
  #   #redirect_url: 'bar.com.br'
  # }
  #
  # response = PagSeguro::Authorization.new(options)#.authorize


end
