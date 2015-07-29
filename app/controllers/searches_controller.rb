class SearchesController < ApplicationController
	before_action :logged_in_user

	def new
		@search = current_user.searches.build
		@search_city_options = City.in_order.all.map{ |a| [a.name, a.id] }
		@search_category_options = Category.in_order.all.map{ |a| [a.name, a.id] }
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

	def edit
		@search = Search.find(params[:id])
		@search_city_options = City.in_order.all.map{ |a| [a.name, a.id] }
		@search_category_options = Category.in_order.all.map{ |a| [a.name, a.id] }
	end

	def show
		@search = Search.find_by(id: params[:id])
	end

	def destroy
		@search = Search.find(params[:id]).destroy
		flash[:success] = "Search deleted"
		redirect_to current_user
	end

	def update
		@search = Search.find(params[:id])
		@search.assign_attributes(search_params)

		if @search.changed?
			if @search.save
				flash[:success] = "Updated"
				redirect_to user_search_path(current_user.id, @search.id)
				#delete all prior hits for search
				@search.hits.delete_all
			else
				render 'edit'
			end
		end


	end


	private

		def search_params
			params.require(:search).permit(:title, :category_id, :city_id, :query).merge(url: "#{City.find(params[:search][:city_id]).url}/search/#{Category.find(params[:search][:category_id]).code}?query=#{params[:search][:query].tr(" ", "+")}")
		end

		def update_hits
			@search = Search.find(params[:id])
			@search.refresh
		end

end
