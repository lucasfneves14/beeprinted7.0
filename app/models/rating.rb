class Rating < ApplicationRecord
	belongs_to :modeler, optional:true
	belongs_to :job, optional:true
end
