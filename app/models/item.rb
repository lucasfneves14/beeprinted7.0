class Item < ApplicationRecord
	belongs_to :orcamento, inverse_of: :items, optional: true
end
