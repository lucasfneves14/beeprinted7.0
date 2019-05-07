class Blog < ApplicationRecord
	mount_uploader :attachment, BlogImageUploader
	belongs_to :user
	has_and_belongs_to_many :categorium

	validates :title, presence: true
	validates :summary, presence: true
	validates :attachment, presence: true
	validates :url, presence: true
	validates :seo_title, presence: true
	validates :seo_meta, presence: true
	validates :body, presence: true 
end
