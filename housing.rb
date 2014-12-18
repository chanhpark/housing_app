require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'pry'


zipcodes = []

CSV.foreach("zipcode.csv", headers: true) do |row|{ zipcode: row['zipcode'] }
  row.each { |key,value| zipcodes << value }
end

zipcodes.each do |code|

  url = "http://www.zillow.com/homes/#{code}_rb"

  html = open(url)
  scrape = Nokogiri::HTML(html)

  scrape.css(".property-info").each do |info|
    if info.css(".routable") != nil
      size = info.css(".property-data").text
      price = info.css(".price-large").text
      address = info.css(".routable").text
    end
    CSV.open("zillow_info.csv", 'a') do |csv|
      csv << [address, size, price]
    end
  end
end
