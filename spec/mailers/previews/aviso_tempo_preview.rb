# Preview all emails at http://localhost:3000/rails/mailers/aviso_tempo
class AvisoTempoPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/aviso_tempo/tempo_acabando
  def tempo_acabando
    AvisoTempo.tempo_acabando
  end

end
