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
	price << rent.text
end
# puts price

info = []
page.css('div.text-muted.listing-location.text-truncate').each do |details|
	info << details.text.strip.split(/ · /)
end
# puts info

# Write data to CSV file
CSV.open("airbnb_listings.csv","w") do |file|
	file << ["Listing Name", "Rent", "Room Type", "Number of Reviews", "Location"]
	name.length.times do |i|
		file << [name[i], price[i], info[i][0], info[i][1], info[i][2]]
	end
end		