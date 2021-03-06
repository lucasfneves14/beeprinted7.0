class Item < ApplicationRecord
	mount_uploader :attachment, ArquivoUploader
	belongs_to :orcamento, inverse_of: :items, optional: true
	belongs_to :modeling, inverse_of: :items, optional: true
	belongs_to :adicionado, inverse_of: :items, optional: true
end
