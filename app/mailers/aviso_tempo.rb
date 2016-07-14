class AvisoTempo < ApplicationMailer
  default from: "itaborai.rotativo@gmail.com"

  def tempo_acabando(current_user)
    @user = current_user

    mail to: current_user.email, subject: "Tempo do bilhete terminando - Faltam menos de 10 minutos"
  end
end
