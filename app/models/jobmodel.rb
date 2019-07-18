class Jobmodel < ApplicationRecord
	mount_uploader :attachment, ArquivoUploader
	belongs_to :job, optional: true
end
