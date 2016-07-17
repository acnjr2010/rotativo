class NotificationsController < ApplicationController
  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token, only: :create

    def create
      transaction = PagSeguro::Transaction.find_by_code(params[:notificationCode])

      if transaction.errors.empty?
        # Processa a notificação. A melhor maneira de se fazer isso é realizar
        # o processamento em background. Uma boa alternativa para isso é a
        # biblioteca Sidekiq.
      end

      render nothing: true, status: 200
    end
end
