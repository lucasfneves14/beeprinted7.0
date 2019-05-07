class Orcamento < ApplicationRecord
	attr_accessor :array
	has_many :arquivos, dependent: :destroy
end
