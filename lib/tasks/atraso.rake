namespace :atraso do
  desc "Rake task to alert"
  task alerta: :environment do

  	orcamentos = Orcamento.where(status: 'Fechado')
  	modelagens = Modeling.where(status: 'Fechado')
  	adicionados = Adicionado.where(status: 'Fechado')
  	planilha = (modelagens + orcamentos + adicionados).sort{|a,b| a.created_at <=> b.created_at }
  	@atrasados = planilha.select{|orcamento| (orcamento.prazo_final!= "")&&((DateTime.parse(orcamento.prazo_final) - Date.today) < 2)&&((DateTime.parse(orcamento.prazo_final) - Date.today) > 0.days)}
  	@atrasados.each do |atrasado|
  		if atrasado.responsavel == "Thierre"
  			AlertaMailer.alerta_email(atrasado, "thierre@beeprinted.com.br").deliver
  		elsif atrasado.responsavel == "Iago"
  			AlertaMailer.alerta_email(atrasado, "iago@beeprinted.com.br").deliver
  		end
  		AlertaMailer.alerta_email(atrasado, "thiago@beeprinted.com.br").deliver
  	end
  end

end
