class Categorium < ApplicationRecord
	has_and_belongs_to_many :blogs
end
