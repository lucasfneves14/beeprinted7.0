class Contato < ApplicationRecord
	attr_accessor :captcha


	validates :captcha, presence: true, numericality: {equal_to: 6, only_integer: true}
	validates :name, presence: true
	validates :email, presence: true
	validates :mensagem, presence: true
end
