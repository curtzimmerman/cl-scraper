module CitiesHelper

	def get_name_by_id(id)
		City.find(id).name
	end

end