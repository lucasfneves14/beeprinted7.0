class ContatoMailer < ApplicationMailer
	default from: "contato@beeprinted.com.br"
	def contato_email(contato)
    	@contato = contato
    	mail(to: 'thiago@beeprinted.com.br', subject: "Contato (#{@contato.id}) - BEEPRINTED")
  	end
end
