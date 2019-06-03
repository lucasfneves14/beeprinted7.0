class Modeling < ApplicationRecord
	attr_accessor :array
	has_many :references, dependent: :destroy
	belongs_to :user

	validates :user_id, presence: true
	validates :tipo, presence: true
	validates :prazo, presence: true
	validates :description, presence: true
end
