class ContatoMailer < ApplicationMailer
	default from: "contato@beeprinted.com.br"
	def contato_email(contato, identificador)
    	@contato = contato
    	@identificador = identificador
    	mail(to: 'iago@beeprinted.com.br', subject: "Contato (#{@identificador}) - BEEPRINTED")
  	end
end
