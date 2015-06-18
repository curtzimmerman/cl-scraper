class SearchesController < ApplicationController
	before_action :logged_in_user
	before_action :update_hits, only: :show

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

	def show
		@search = Search.find_by(id: params[:id])
	end


	private

		def search_params
			params.require(:search).permit(:title, :city_id, :query)
		end

		def update_hits
			@search = Search.find(params[:id])
			@search.update_hits
		end

end
