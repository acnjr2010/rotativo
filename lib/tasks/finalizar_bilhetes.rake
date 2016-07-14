namespace :bilhete_status_finalizado do
  desc "Finalizar Bilhetes"
  task :finalizar_bilhete => :environment do
    @bilhetes = Bilhete.where(status: 1)
    @bilhetes.each do |bilhete|
      if (Time.current > bilhete.ativado_em + 3600 && bilhete.setor_id == 1 && bilhete.periodo == 1)
        bilhete.status = 2
        bilhete.save
      end

      if (Time.current > bilhete.ativado_em + 7200 && bilhete.setor_id == 1 && bilhete.periodo == 2)
        bilhete.status = 2
        bilhete.save
      end

      if (Time.current > bilhete.ativado_em + 7200 && bilhete.setor_id == 2 && bilhete.periodo == 1)
        bilhete.status = 2
        bilhete.save
      end

      if (Time.current > bilhete.ativado_em + 14400 && bilhete.setor_id == 2 && bilhete.periodo == 2)
        bilhete.status = 2
        bilhete.save
      end

      if (Time.current > bilhete.ativado_em + 14400 && bilhete.setor_id == 3 && bilhete.periodo == 1)
        bilhete.status = 2
        bilhete.save
      end

      if (Time.current > bilhete.ativado_em + 18000 && bilhete.setor_id == 3 && bilhete.periodo == 2)
        bilhete.status = 2
        bilhete.save
      end
    end
  end
end
