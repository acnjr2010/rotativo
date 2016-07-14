namespace :aviso_termino_bilhete do
  desc "Email de aviso do termino do bilhete"
  task :envio_email => :environment do
    @bilhetes = Bilhete.where(status: 1)
    @bilhetes.each do |bilhete|
      if Time.current > bilhete.ativado_em + 3000
        AvisoTempo.tempo_acabando(bilhete.user).deliver
      end
    end
  end
end
