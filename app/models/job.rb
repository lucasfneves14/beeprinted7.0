class Job < ApplicationRecord
	attr_accessor :array
	mount_uploader :image, JobFirstUploader
	has_many :images, dependent: :destroy
	belongs_to :modeler, optional:true
	has_many :jobmodels, dependent: :destroy
	has_many :job_notifications, dependent: :destroy
end
