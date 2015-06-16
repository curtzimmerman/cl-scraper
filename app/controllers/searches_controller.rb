class SearchesController < ApplicationController


	def new
		@search = current_user.searches.build
		@search_city_options = City.in_order.all.map{ |a| [a.name, a.id] }
	end

	def create
		@search = current_user.searches.build(search_params)
		if @search.save
			flash[:success] = "Search created"
			redirect_to current_user
		else
			render 'new'
		end
	end


	private

		def search_params
			params.require(:search).permit(:title, :location, :query)
		end
end