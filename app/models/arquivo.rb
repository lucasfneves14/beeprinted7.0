class Arquivo < ApplicationRecord
	mount_uploader :attachment, ImageUploader
	belongs_to :orcamento, optional: true

	#validates :attachment, presence: true
end
