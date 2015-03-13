require 'open-uri'
require 'nokogiri'

url="http://en.wikipedia.org/wiki/List_of_current_NBA_team_rosters"
page = Nokogiri::HTML(open(url))

puts page.css('a')

puts page.css('li.toclevel-3')

puts page.css('td[style="text-align:left;"]')

puts page.css('td[style="text-align:left;"]').text

page.css('td[style="text-align:left;"]').each do |player|
	puts player.text
end