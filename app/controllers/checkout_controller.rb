class CheckoutController < ApplicationController
  def create
      # O modo como você irá armazenar os produtos que estão sendo comprados
      # depende de você. Neste caso, temos um modelo Order que referência os
      # produtos que estão sendo comprados.
      order = Order.find(params[:id])

      payment = PagSeguro::PaymentRequest.new
      payment.reference = order.id
      payment.notification_url = notifications_url
      payment.redirect_url = processing_url

      order.products.each do |product|
        payment.items << {
          id: product.id,
          description: product.title,
          amount: product.price,
          weight: product.weight
        }
      end

      # Caso você precise passar parâmetros para a api que ainda não foram mapeados na gem,
      # você pode fazer de maneira dinâmica utilizando um simples hash.
      # payment.extra_params << { paramName: 'paramValue' }
      payment.extra_params << { senderBirthDate: '07/05/1981' }
      payment.extra_params << { extraAmount: '-15.00' }

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
