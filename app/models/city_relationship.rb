class CityRelationship < ActiveRecord::Base
	belongs_to :nearby_city, class_name: "City"
	belongs_to :is_near_to, class_name: "City"

end