require 'open-uri'
require 'nokogiri'
require 'csv'

# Store URL to be scrapped
	url="https://www.airbnb.com/s/New-York--NY--United-States"
	
# Parse the page with Nokogiri
	page = Nokogiri::HTML(open(url))

# Scrape the max number of pages and store it in max_page variable
page_numbers = []
page.css("div.pagination ul li a[target]").each do |pnum|
	page_numbers << pnum.text
end

max_page = page_numbers.max
name = []
price = []
info = []

max_page.to_i.times do |i|
#  our computer interprets this max_page variable as a string, or text, but the .times method that creates the loop requires an integer. The .to_i tells our computer to interpret this as an integer instead
	
	# Open Search Results Page
	url="https://www.airbnb.com/s/New-York--NY--United-States?page=#{i+1}"
	
	# Parse the page with Nokogiri
	search_page = Nokogiri::HTML(open(url))

	# Store data in arrays
	search_page.css('div.h5.listing-name').each do |apartment|
		name << apartment.text.strip
	end
	
	search_page.css('span.h3.price-amount').each do |rent|
		price << rent.text
	end
	
	search_page.css('div.text-muted.listing-location.text-truncate').each do |details|
		info << details.text.strip.split(/ · /)
	end
end	

# Write data to CSV file
CSV.open("airbnb_listings.csv","w") do |file|
	file << ["Listing Name", "Rent", "Room Type", "Number of Reviews", "Location"]
	name.length.times do |i|
		file << [name[i], price[i], info[i][0], info[i][1], info[i][2]]
	end
end		