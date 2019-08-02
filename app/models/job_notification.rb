class JobNotification < ApplicationRecord
	belongs_to :job, optional:true
	belongs_to :modeler, optional:true
end
