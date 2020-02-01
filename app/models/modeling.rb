class Modeling < ApplicationRecord
	attr_accessor :array
	default_scope {where("ativo = true")}
	has_many :references, dependent: :destroy
	has_many :items, inverse_of: :modeling, dependent: :destroy
	accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
	has_many :servicos, inverse_of: :modeling, dependent: :destroy
	accepts_nested_attributes_for :servicos, reject_if: :all_blank, allow_destroy: true
	belongs_to :user, optional:true

	has_many :job_notifications, dependent: :destroy

	validates :tipo, presence: true
	validates :prazo, presence: true
	validates :description, presence: true
	validates :name, presence: true
	validates :sobrenome, presence: true
	validates :estado, presence: true
	validates :email, presence: true
	validates :empresa, presence: true, on: :create
	validates_format_of :email,:with => Devise::email_regexp
	validates :cep, presence: true, if: :fora_de_brasilia?

	amoeba do
		enable
	end


	def fora_de_brasilia?
		estado != "Distrito Federal"
	end
end
