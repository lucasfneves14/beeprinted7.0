class HivesController < ApplicationController
	layout false
	before_action :authenticate_modeler!, raise: false
	def index

	end
end
