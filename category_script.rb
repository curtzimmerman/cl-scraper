require 'open-uri'
require 'nokogiri'
require 'csv'

target = File.open("/home/curt/dev/rails/cl-scraper/louisville\ for\ sale\ -\ craigslist.html", "r")

doc = Nokogiri::HTML(target)
target.close
CSV.open("category_list.csv", "w") do |csv|
	doc.css("li a.category").each do |node|
		node.attr("href").match(/\/search\/?(.*)/)
		c = $1
		csv << [node.text, c]
	end
end
