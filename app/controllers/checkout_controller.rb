class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def create
      # O modo como você irá armazenar os produtos que estão sendo comprados
      # depende de você. Neste caso, temos um modelo Order que referência os
      # produtos que estão sendo comprados.
      order = Order.find(params[:id])

      payment = PagSeguro::PaymentRequest.new
      payment.credentials = PagSeguro::AccountCredentials.new('nogueira_junior@yahoo.com.br', '2DC455CCF0034741B51CAE3FFEE25C86')
      payment.reference = order.id
      payment.notification_url = notifications_url
      payment.redirect_url = "https://sandbox.pagseguro.uol.com.br"

      #order.produto.each do |product|

        payment.items << {
          id: order.produto.id,
          description: order.produto.description,
          amount: "4,00",
          weight: 0
        }

        payment.sender = {
          name: current_user.nome,
          email: "c56244240426840483280@sandbox.pagseguro.com.br",
          document: { type: "CPF", value: "21639716866" },
          phone: {
            area_code: 13,
            number: "12345678"
          }
        }

        #puts "=> REQUEST"
        #puts PagSeguro::PaymentRequest::RequestSerializer.new(payment).to_params

        #response = payment.register

        #puts
        #puts "=> RESPONSE"
        #puts response.url
        #puts response.code
        #puts response.created_at
        #puts response.errors.to_a
        byebug
      #end

      response = payment.register
      # Caso o processo de checkout tenha dado errado, lança uma exceção.
      # Assim, um serviço de rastreamento de exceções ou até mesmo a gem
      # exception_notification poderá notificar sobre o ocorrido.
      #
      # Se estiver tudo certo, redireciona o comprador para o PagSeguro.
      if response.errors.any?
        raise response.errors.join("\n")
      else
        redirect_to response.url
      end
    end
end
