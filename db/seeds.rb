Orcamento.all.each do |orcamento|
	if orcamento.cep == ""
		orcamento.cep = "-"
		orcamento.save
	end
end

Modeling.all.each do |modelagem|
	if modelagem.cep == ""
		modelagem.cep = "-"
		modelagem.save
	end
end

Adicionado.all.each do |adicionado|
	if adicionado.cep == ""
		adicionado.cep = "-"
		adicionado.save
	end
end
