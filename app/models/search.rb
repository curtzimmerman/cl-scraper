class Search < ActiveRecord::Base
	belongs_to :user 
	belongs_to :city
	has_many :hits

	validates :title, presence: true, length: { maximum: 50 }
	validates :city, presence: true
	validates :query, presence: true, length: { maximum: 255 }

	def update_hits
		#"http://#{city}.craigslist.org/search/cto?query=datsun&srchType=T&minAsk=300&maxAsk=1500"
		query_url = "/search/cto?query=#{self.query.tr(" ", "+")}"
		search_cities = self.city + self.city.nearby_cities
		search_cities.each do |city|
			hitlist = self.hits
			url = city.url + query_url
			doc = Nokogiri::HTML(open(url))
			doc.css("div.rightpane div.content p.row").each do |row|
				if !self.hits.pluck('data_pid').include?(row['data-pid'])
					self.hit.build(
						url: city.url +  )
				#if the posting id is in hitlist
					#set hitlist[hit][posting_id, true]
			#end
			#delete search.hits where bool = false 


	end
end
