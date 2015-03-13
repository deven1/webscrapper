require 'open-uri'
require 'nokogiri'

# Store URL to be scrapped
url="https://www.airbnb.com/s/New-York--NY--United-States"

# Parse the page with Nokogiri
page = Nokogiri::HTML(open(url))

# Display output onto the screen
page.css('div.h5.listing-name').each do |apartment|
	puts apartment.text
end

page.css('span.h3.price-amount').each do |rent|
	puts rent.text
end

page.css('div.text-muted.listing-location.text-truncate').each do |details|
	puts details.text
end