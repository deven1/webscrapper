require 'open-uri'
require 'nokogiri'
require 'csv'

# Store URL to be scrapped
url="https://www.airbnb.com/s/New-York--NY--United-States"

# Parse the page with Nokogiri
page = Nokogiri::HTML(open(url))

# Store data in arrays
name = []
page.css('div.h5.listing-name').each do |apartment|
	name << apartment.text.strip
end
# puts name

price = []
page.css('span.h3.price-amount').each do |rent|
	price << rent.text.strip
end

info = []
page.css('div.text-muted.listing-location.text-truncate').each do |details|
	info << details.text.strip
end

# Write data to CSV file
CSV.open("airbnb_listings.csv","w") do |file|
	file << ["Listing Name", "Rent", "Details"]
	name.length.times do |i|
		file << [name[i], price[i], info[i]]
	end
end		