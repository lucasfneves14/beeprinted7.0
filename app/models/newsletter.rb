class Newsletter < ApplicationRecord
	validates :email, presence: true
end
