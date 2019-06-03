class Modeling < ApplicationRecord
	attr_accessor :array
	has_many :references, dependent: :destroy
	belongs_to :user

	validates :user_id, presence: true
end
