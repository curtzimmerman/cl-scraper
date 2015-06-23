class Search < ActiveRecord::Base
	require 'open-uri'

	belongs_to :user 
	belongs_to :city
	has_many :hits

	validates :title, presence: true, length: { maximum: 50 }
	validates :city, presence: true
	validates :query, presence: true, length: { maximum: 255 }

	def self.format_query_for_url(city_url, search_query)
		"#{city_url}/search/cto?query=#{search_query.tr(" ", "+")}"
	end

	def refresh
		self.update_hits(self.city)
		search_cities = self.city.nearby_cities
		search_cities.each do |city|
			self.update_hits(city)
		end
		Hit.where(checked: false).destroy_all
	end

	def update_hits(city)
		doc = Nokogiri::HTML(open(Search.format_query_for_url(city.url, self.query)))
		current_hits = self.hits.pluck('data_pid')
		doc.css("div.rightpane div.content p.row").each do |row|
			if current_hits.nil? || !current_hits.include?(row['data-pid'])
				self.hits.create(
					data_pid: row['data-pid'],
					url: Hit.format_hit_url(city.url, row.css('a')[0]['href']), 
					title: row.css('a.hdrlnk')[0].text,
					price: row.css('span.txt span.l2 span.price').text.tr("$", "").to_i,
					neighborhood: row.css('span.txt span.l2 span.pnr small').text,
					checked: true)
			else
				Hit.find_by(url: Hit.format_hit_url(city.url, row.css('a')[0]['href'])).update_attribute(:checked, true)
			end
		end
	end

	
end
