class Orcamento < ApplicationRecord
	attr_accessor :array
	has_many :arquivos, dependent: :destroy
	#belongs_to :user

	validates :arquivos, presence: true
	validates :name, presence: true
	validates :email, presence: true
end
