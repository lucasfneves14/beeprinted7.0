namespace :atraso do
  desc "Rake task to alert"
  task alerta: :environment do
  	puts "Ultimo orçamento:"
  	puts Orcamento.last.identificador
  	puts "#{Time.now} - Success"
  end

end
