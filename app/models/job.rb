class Job < ApplicationRecord
	attr_accessor :array
	mount_uploader :image, JobFirstUploader
	belongs_to :modeler, optional:true
	has_many :jobmodels, dependent: :destroy
end
