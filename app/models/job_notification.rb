class JobNotification < ApplicationRecord
	belongs_to :job, optional:true
	belongs_to :modeler, optional:true

	belongs_to :orcamento, optional:true
	belongs_to :modeling, optional:true
	belongs_to :adicionado, optional:true
end
