class Reference < ApplicationRecord
	mount_uploader :attachment, ReferenceUploader
	belongs_to :modeling, optional: true
end
