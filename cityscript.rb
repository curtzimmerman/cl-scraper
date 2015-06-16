require 'nokogiri'
require 'open-uri'
require 'csv'


target = File.open("city_list.html", "r")

doc = Nokogiri::HTML(target)
CSV.open("city_list.csv", "w") do |csv|
	doc.css("li a").each do |node|
		csv << [node.text, node.attr("href")]
	end
end
target.close

