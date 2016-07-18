class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def create
      # O modo como você irá armazenar os produtos que estão sendo comprados
      # depende de você. Neste caso, temos um modelo Order que referência os
      # produtos que estão sendo comprados.
      order = Order.find(params[:id])

      payment = PagSeguro::PaymentRequest.new
      #payment.credentials = PagSeguro::AccountCredentials.new('nogueira_junior@yahoo.com.br', '1CB53BF644F24A79863390C087CD0E29')
      payment.credentials = PagSeguro::AccountCredentials.new('nogueira_junior@yahoo.com.br', '2DC455CCF0034741B51CAE3FFEE25C86')
      payment.reference = order.id
      payment.abandon_url =  "localhost:3000/users/#{current_user.id}/problema_pagamento"
      payment.notification_url = notifications_url
      payment.redirect_url = "localhost:3000/users/#{current_user.id}/consulta"

      payment.items << {
        id: order.setor_id,
        description: Setor.find(order.setor_id).cor,
        amount: order.valor_bilhete,
        weight: 0
      }

      payment.sender = {
        name: current_user.nome,
        email: "c56244240426840483280@sandbox.pagseguro.com.br",
        document: { type: "CPF", value: current_user.cpf },
      }

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

    def consulta_venda
      @transacao = params[:transaction_id]

      #@xml_pagseguro = Nokogiri::XML(open("https://ws.pagseguro.uol.com.br/v3/transactions/#{@transacao}/?email=nogueira_junior@yahoo.com.br&token=1CB53BF644F24A79863390C087CD0E29"))
      @xml_pagseguro = Nokogiri::XML(open("https://ws.sandbox.pagseguro.uol.com.br/v3/transactions/#{@transacao}/?email=nogueira_junior@yahoo.com.br&token=2DC455CCF0034741B51CAE3FFEE25C86"))
      @status = @xml_pagseguro.css('status').children.first.content
      @valor = @xml_pagseguro.css('amount').children.first.content
      @setor = @xml_pagseguro.css('description').children.first.content


      if @status === "3"
        @order = Order.where(user: current_user).last
        @order.update_attributes(transaction_id: @transacao)

        @order.save
        redirect_to new_user_bilhete_path(current_user)
      else
        redirect_to tela_erro_path
      end
    end

    def tela_erro
    end

    private

    def valor_bilhete(order)
      if order.price == 1
        return 2.00
      else
        return 4.00
      end
    end
end
