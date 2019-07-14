class HivesController < ApplicationController
	before_action :authenticate_modeler!, raise: false
	layout 'hives/navbar'
	before_action :authenticate_modeler!, raise: false
	def index

	end
end
