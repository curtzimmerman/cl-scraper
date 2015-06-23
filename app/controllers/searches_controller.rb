class SearchesController < ApplicationController
	before_action :logged_in_user
	before_action :update_hits, only: [:show]

	def new
		@search = current_user.searches.build
		@search_city_options = City.in_order.all.map{ |a| [a.name, a.id] }
	end

	def create
		@search = current_user.searches.build(search_params)
		if @search.save
			@search.city.get_nearby if @search.city.nearby_cities.empty? 
			flash[:success] = "Search created"
			redirect_to current_user
		else
			render 'new'
		end
	end

	def show
		@search = Search.find_by(id: params[:id])
	end

	def destroy
		@search = Search.find(params[:id]).destroy
		flash[:success] = "Search deleted"
		redirect_to current_user
	end


	private

		def search_params
			params.require(:search).permit(:title, :city_id, :query).merge(url: "#{City.find(params[:search][:city_id]).url}/search/cto?query=#{params[:search][:query].tr(" ", "+")}")
		end

		def update_hits
			@search = Search.find(params[:id])
			@search.refresh
		end

end
