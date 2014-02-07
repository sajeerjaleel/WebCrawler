class EpldatasController < ApplicationController
	
	def table
		@epldata = Epldata.all
		@a = 0
		@count = 1
	end

	def home
	end

	def fixtures
		@fixtures = Fixtures.all
	end

	def results
		@results = Result.all
	end

	def kaminar
		@results = Result.order("date").page(params[:page])
	end
	
end
