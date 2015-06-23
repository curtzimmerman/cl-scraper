class City < ActiveRecord::Base
	has_many :searches
	has_many :hits, through: :searches

	has_many :city_relationships, class_name: "CityRelationship"
	has_many :nearby_cities, through: :city_relationships

	scope :in_order, -> { order(name: :asc) }

	def get_nearby
		doc = Nokogiri::HTML(open(self.url))
		doc.css("div#rightbar ul.menu li.expand.s ul.acitem li.s").each do |nearby|
			nearby_city_formatted = "http:#{nearby.css('a').first['href']}"
			unless nearby_city_formatted.match(/\.mx$/)
				nearby_city_id = City.find_by(url: nearby_city_formatted).id
				self.city_relationships.create(nearby_city_id: nearby_city_id)
			end
		end
	end
end
