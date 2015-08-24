class Hit < ActiveRecord::Base
	belongs_to :search
	has_one :user, through: :search

	#cl at times only puts relative addresses for hits, this converts them into absolute addresses
	def self.format_hit_url(city_url, partial)
		url = partial.match(/^http/) ? partial : "#{city_url}#{partial}"
		return partial if partial.match(/^http/)
		return "http:#{partial}" if partial.match(/^\/\//)
		return "#{city_url}#{partial}"
	end


end
