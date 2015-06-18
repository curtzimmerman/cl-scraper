require 'nokogiri'
require 'open-uri'

title = (div.content p.row span.txt span.pl a.hdrlink).text
posted_date = (div.content p.row span.txt span.pl time[:date_time])
price = (div.content p.row span.txt span.l2 span.price).text
neighborhood = (div.content p.row span.txt span.l2 span.pnr small).text

doc = Nokogiri::HTML(open(target))

File.open("hits.html", 'w') do |file|
	doc.css("div.content p.row").each do |row|
		file << row
	end
end



