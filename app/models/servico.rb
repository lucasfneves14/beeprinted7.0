class Servico < ApplicationRecord
	belongs_to :orcamento, inverse_of: :servicos, optional: true
	belongs_to :modeling, inverse_of: :servicos, optional: true
	belongs_to :adicionado, inverse_of: :servicos, optional: true
end
