class Image < ApplicationRecord
	mount_uploader :attachment, ImageUploader
	belongs_to :post, optional: true
	belongs_to :job, optional: true

	validates :attachment, presence: true
end
