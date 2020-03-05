namespace :atraso do
  desc "Rake task to alert"
  task alerta: :environment do

  	orcamentos = Orcamento.where(status: 'Fechado')
  	modelagens = Modeling.where(status: 'Fechado')
  	adicionados = Adicionado.where(status: 'Fechado')
  	planilha = (modelagens + orcamentos + adicionados).sort{|a,b| a.created_at <=> b.created_at }
  	@atrasados = planilha.select{|orcamento| (orcamento.prazo_final!= "")&&((DateTime.parse(orcamento.prazo_final) - Date.today) < 2)&&((DateTime.parse(orcamento.prazo_final) - Date.today) > 0.days)}
  	@atrasados.each do |atrasado|
  		AlertaMailer.alerta_email(atrasado).deliver
  		puts atrasado.identificador
  	end
  end

end
