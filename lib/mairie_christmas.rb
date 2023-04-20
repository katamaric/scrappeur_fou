require 'nokogiri'
require 'open-uri'

# Method to get town hall email
def get_townhall_email(townhall_url)
  doc = Nokogiri::HTML(URI.open(townhall_url))
  email = doc.xpath('//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
  return email
end

# Method to get town hall urls
def get_townhall_urls
  doc = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
  urls = doc.css(".lientxt").map { |link| "http://annuaire-des-mairies.com/" + link["href"][2..-1] }
  return urls
end

# Method to create array of hashes
def create_array_of_hashes
  urls = get_townhall_urls
  array_of_hashes = []
  urls.each do |url|
    name = url.split("/").last.split(".").first.capitalize.gsub("_", " ")
    email = get_townhall_email(url)
    array_of_hashes << { name => email }
  end
  return array_of_hashes
end

p create_array_of_hashes
