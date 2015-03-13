require 'open-uri'
require 'nokogiri'

# Store URL to be scrapped
url="http://en.wikipedia.org/wiki/List_of_current_NBA_team_rosters"

# Parse the page with Nokogiri
page = Nokogiri::HTML(open(url))

# Display output onto the screen
puts page
puts page.css('a')
puts page.css('li.toclevel-3')
puts page.css('td[style="text-align:left;"]')
puts page.css('td[style="text-align:left;"]').text

page.css('td[style="text-align:left;"]').each do |player|
	puts player.text
end