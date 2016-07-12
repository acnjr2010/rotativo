class BilhetesController < ApplicationController
  before_action :authenticate_user!

  def new
    @bilhete = current_user.bilhetes.build
    @veiculo = current_user.veiculos
  end

  def create

    # O modo como você irá armazenar os produtos que estão sendo comprados
    # depende de você. Neste caso, temos um modelo Order que referência os
    # produtos que estão sendo comprados.
    @bilhete = current_user.bilhetes.build(params.require(:bilhete).permit(:preco, :descricao, :setor, :veiculo, :placa_veiculo))

    # order = Bilhete.find(params[:id])

    payment = PagSeguro::PaymentRequest.new#(email: 'nog.junior84@gmail.com', token: 'AC95709BEB6C47D68C80DE2E01ED9D60')

    # Você também pode fazer o request de pagamento usando credenciais
    # diferentes, como no exemplo abaixo


    payment.reference = @bilhete.id
    payment.notification_url = "lalalalalalalala.com.br"
    payment.redirect_url = "localhost:3000/veiculos"
    # order.products.each do |product|
      payment.items << {
        id: 1,
        description: "Bilhete",#product.title,
        amount: 2.00,#product.price,
        #weight: 0#product.weight
      }
    #end

    # Caso você precise passar parâmetros para a api que ainda não foram
    # mapeados na gem, você pode fazer de maneira dinâmica utilizando um
    # simples hash.
    # payment.extra_params << { paramName: 'paramValue' }
    # payment.extra_params << { senderBirthDate: '07/05/1981' }
    # payment.extra_params << { extraAmount: '-15.00' }

    response = payment.register
    byebug
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
