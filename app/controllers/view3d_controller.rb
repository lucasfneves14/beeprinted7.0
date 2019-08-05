class View3dController < ApplicationController
	layout false

	def show
		@model = Jobmodel.find(params[:id])
	end
end
