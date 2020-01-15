class Adicionado < ApplicationRecord
	has_many :items, inverse_of: :adicionado, dependent: :destroy
	accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
	has_many :servicos, inverse_of: :adicionado, dependent: :destroy
	accepts_nested_attributes_for :servicos, reject_if: :all_blank, allow_destroy: true
	
	belongs_to :user, optional:true
	
	has_many :job_notifications, dependent: :destroy

	validates :name, presence: true
	validates :responsavel, presence: true
end
