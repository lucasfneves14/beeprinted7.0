class Arquivo < ApplicationRecord
	mount_uploader :attachment, ArquivoUploader
	belongs_to :orcamento, optional: true

	#validates :attachment, presence: true
end
