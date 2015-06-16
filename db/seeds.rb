require 'csv'

cities = CSV.read("#{Rails.root}/lib/assets/city_list.csv")
cities.each do |name, url|
	City.find_or_create_by(url: url) { |city| city.name = name.titleize }
end