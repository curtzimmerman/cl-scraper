class Search < ActiveRecord::Base
	require 'open-uri'

	belongs_to :user 
	belongs_to :city
	has_many :hits
	belongs_to :category

	validates :title, presence: true, length: { maximum: 50 }
	validates :city, presence: true
	validates :query, presence: true, length: { maximum: 255 }

	def self.format_query_for_url(city_url, search_category, search_query)
		url = "#{city_url}/search/#{search_category}?" #"query=#{search_query.tr(" ", "+")}"
		search_query.each do |key, value|
			url += "&#{key}=#{value}"
		end
		url.tr(" ", "+")
	end

	def refresh
		#set all previous hits to checked=false
		Hit.where(search_id: self.id).update_all(checked: false)
		#update hits for home city
		self.update_hits(self.city)

		#get array of all nearby cities to home city and iterate through them
		search_cities = self.city.nearby_cities
		search_cities.each do |city|
			self.update_hits(city)
		end

		#if the hits were not found in the searches, delete them
		Hit.where(search_id: self.id, checked: false).delete_all
	end

	def update_hits(city)
		#get the search page using nokogiri
		doc = Nokogiri::HTML(open(Search.format_query_for_url(city.url, self.category.code, self.parameters_for_search_url)))

		#get array of all ids of hits currently in the database to check against
		current_hits = self.hits.pluck('data_pid')
		#iterate over every hit on the page
		#TODO: add checking for pagination
		doc.css("div.rightpane div.content p.row").each do |row|
			if current_hits.nil? || !current_hits.include?(row['data-pid'])
				self.hits.create(
					data_pid: row['data-pid'],
					url: Hit.format_hit_url(city.url, row.css('a')[0]['href']), 
					title: row.css('a.hdrlnk')[0].text,
					price: row.css('span.txt span.l2 span.price').text.tr("$", "").to_i,
					neighborhood: row.css('span.txt span.l2 span.pnr small').text,
					checked: true)
			elsif
				#if the document does contain the pid and the current hits listing does also, update the attributes
				Hit.find_by_data_pid(row['data-pid']).update_attributes(
					title: row.css('a.hdrlnk')[0].text,
					price: row.css('span.txt span.l2 span.price').text.tr("$", "").to_i,
					neighborhood: row.css('span.txt span.l2 span.pnr small').text,
					checked: true)
			end
		end
	end

	def parameters_for_search_url
		{ query: self.query, min_price: self.min_price, max_price: self.max_price }
	end

	
end
