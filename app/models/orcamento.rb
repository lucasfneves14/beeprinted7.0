class Orcamento < ApplicationRecord
	require 'csv'
	attr_accessor :array
	has_many :arquivos, -> { order(:attachment => :asc) }, dependent: :destroy
	has_many :items, inverse_of: :orcamento, dependent: :destroy
	accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
	has_many :servicos, inverse_of: :orcamento, dependent: :destroy
	accepts_nested_attributes_for :servicos, reject_if: :all_blank, allow_destroy: true


	#belongs_to :user

	validates :arquivos, presence: true
	validates :name, presence: true
	validates :sobrenome, presence: true
	validates :estado, presence: true
	validates :email, presence: true
	validates_format_of :email,:with => Devise::email_regexp
	validates :cep, presence: true, if: :fora_de_brasilia?


	def fora_de_brasilia?
		estado != "Distrito Federal"
	end

end
