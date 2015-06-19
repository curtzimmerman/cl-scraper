class NearbyCity < ActiveRecord::Base
	belongs_to :city
	belongs_to :nearby_city, class_name: "City"
end