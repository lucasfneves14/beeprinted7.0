class Modeling < ApplicationRecord
	attr_accessor :array
	has_many :references, dependent: :destroy
	#belongs_to :user

	validates :tipo, presence: true
	validates :prazo, presence: true
	validates :description, presence: true
	validates :name, presence: true
	validates :email, presence: true
end
