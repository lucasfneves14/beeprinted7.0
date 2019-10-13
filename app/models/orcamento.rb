class Orcamento < ApplicationRecord
	require 'csv'
	attr_accessor :array
	has_many :arquivos, dependent: :destroy
	#belongs_to :user

	validates :arquivos, presence: true
	validates :name, presence: true
	validates :sobrenome, presence: true
	validates :estado, presence: true
	validates :email, presence: true

end
