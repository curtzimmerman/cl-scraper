require 'nokogiri'
require 'open-uri'

rows = []

def get_home_city_url ( home_city_plaintext )
	#store all info in database instead of requerying
	#search database for home city listing, if not there, query CL for list
	return "http://#{home_city_plaintext}.craigslist.org"
end

def get_nearby_cities ( homepage )
	nearby_cities = []
	homepage.css("\#rightbar .expand a").each do |f|
		#take each nokogiri node and convert to string, then match all characters between / and ., then store in s. Should be a MatchData object
		s = f.to_s.match /\/[^\/\.]*\./
		#convert MatchData instance to string, then replace / and . with empty string. Then push to nearby_cities
		nearby_cities.push(s.to_s.tr('/.', ''))
	end
	return nearby_cities
end

def get_hits_in_nearby_cities ( home_city_plaintext )
	home_city_homepage = get_home_city_url(home_city_plaintext)
	nearby_cities = get_nearby_cities(Nokogiri::HTML(open(home_city_homepage)))
	list_of_hits = []
	nearby_cities.each do |city|
		doc = Nokogiri::HTML(open("http://#{city}.craigslist.org/search/cto?query=datsun&srchType=T&minAsk=300&maxAsk=1500")) do |config|
			config.nonet
		end
		doc.css(".row .hdrlnk").each do |f|
			if !list_of_hits.include?(f['data-id'].to_s)
				puts "#{f.text}: #{f['href']}	"
				list_of_hits.push(f['data-id'.to_s])
			end
		end
	end
end

puts "Enter your home city: "
home_city = gets.chomp

get_hits_in_nearby_cities (home_city)