class Orcamento < ApplicationRecord
	attr_accessor :array
	has_many :arquivos, dependent: :destroy
	belongs_to :user

	validates :user_id, presence: true
	validates :arquivos, presence: true
end
