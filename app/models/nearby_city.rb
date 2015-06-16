class NearbyCity < ActiveRecord::Base
	has_one :home_city, class_name: "City"
	belongs_to :city
end
