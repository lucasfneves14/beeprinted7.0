class Adicionado < ApplicationRecord
	has_many :items, inverse_of: :adicionado, dependent: :destroy
	accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
	has_many :servicos, inverse_of: :adicionado, dependent: :destroy
	accepts_nested_attributes_for :servicos, reject_if: :all_blank, allow_destroy: true

	validates :name, presence: true
	validates :estado, presence: true
	validates :email, presence: true
	validates_format_of :email,:with => Devise::email_regexp
end
