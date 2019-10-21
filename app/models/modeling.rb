class Modeling < ApplicationRecord
	attr_accessor :array
	has_many :references, dependent: :destroy
	has_many :items, inverse_of: :modeling, dependent: :destroy
	accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
	has_many :servicos, inverse_of: :modeling, dependent: :destroy
	accepts_nested_attributes_for :servicos, reject_if: :all_blank, allow_destroy: true
	#belongs_to :user

	validates :tipo, presence: true
	validates :prazo, presence: true
	validates :description, presence: true
	validates :name, presence: true
	validates :sobrenome, presence: true
	validates :estado, presence: true
	validates :email, presence: true
	validates :cep, presence: true, if: :fora_de_brasilia?


	def fora_de_brasilia?
		estado != "Distrito Federal"
	end
end
