class Image < ApplicationRecord
	mount_uploader :attachment, ImageUploader
	belongs_to :post, optional: true

	validates :attachment, presence: true
end
