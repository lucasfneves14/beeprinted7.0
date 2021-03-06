class Orcamento < ApplicationRecord
	require 'csv'
	default_scope {where("ativo = true")}


	attr_accessor :array
	has_many :arquivos, -> { order(:attachment => :asc) }, dependent: :destroy
	has_many :items, -> { order(:attachment => :asc) }, inverse_of: :orcamento, dependent: :destroy
	accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
	has_many :servicos, inverse_of: :orcamento, dependent: :destroy
	accepts_nested_attributes_for :servicos, reject_if: :all_blank, allow_destroy: true


	belongs_to :user, optional:true

	has_many :job_notifications, dependent: :destroy

	validates :items, presence: true
	validates :name, presence: true
	validates :sobrenome, presence: true
	validates :estado, presence: true
	validates :email, presence: true
	validates_format_of :email,:with => Devise::email_regexp
	validates :cep, presence: true, if: :fora_de_brasilia?


	amoeba do
		enable
	end

	def start_time
		DateTime.parse(self.prazo_final)
	end


	def fora_de_brasilia?
		estado != "Distrito Federal"
	end

end
