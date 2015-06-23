module CitiesHelper

	def get_name_by_id(city)
		City.find(city.id).name
	end

end