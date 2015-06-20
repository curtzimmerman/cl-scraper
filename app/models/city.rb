class City < ActiveRecord::Base
	has_many :searches
	has_many :hits, through: :searches

	has_many :nearby_cities, class_name: "CityRelationship", foreign_key: "city_id"
	has_many :is_near_to, class_name: "CityRelationship", foreign_key: "nearby_city_id"

	scope :in_order, -> { order(name: :asc) }
end
