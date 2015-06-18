class Search < ActiveRecord::Base
	belongs_to :user 
	belongs_to :city
	has_many :hits

	validates :title, presence: true, length: { maximum: 50 }
	validates :city, presence: true
	validates :query, presence: true, length: { maximum: 255 }

	def update_hits
		#"http://#{city}.craigslist.org/search/cto?query=datsun&srchType=T&minAsk=300&maxAsk=1500"
		foo = "#{self.city.url}/search/cto?query=#{self.query.tr(" ", "+")}"
		binding.pry
	end
end
