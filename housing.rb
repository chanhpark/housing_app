require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://www.zillow.com/homes/07650_rb"
html = open(url)
scrape = Nokogiri::HTML(html)
puts scrape.css("#search-title").text

n = 0
scrape.css(".property-info").each do |info|
  if info.css(".routable") != nil
    size = info.css(".property-data").text
    price = info.css(".price-large").text
    address = info.css(".routable").text
  end
    puts "#{n+=1}) #{address} || #{size} for #{price} "
end
