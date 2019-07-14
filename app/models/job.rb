class Job < ApplicationRecord
	mount_uploader :image, JobFirstUploader
	belongs_to :modeler
end
