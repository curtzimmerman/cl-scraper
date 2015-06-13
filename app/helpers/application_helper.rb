module ApplicationHelper

	def full_title(title)
		default_title = "CLScraper"
		if title
			"#{title} | #{default_title}"
		else
			default_title
		end
	end
end
