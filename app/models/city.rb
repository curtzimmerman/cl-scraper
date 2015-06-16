class City < ActiveRecord::Base
	has_many :searches
	has_many :hits, through: :searches
	has_many :nearby_cities, through: :nearby_cities

	scope :in_order, -> { order(name: :asc) }
end
