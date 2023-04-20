require 'nokogiri'
require 'open-uri'

# Fetch and parse HTML document
doc = Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))

def get_currencies(doc)
  return currencies = doc.css('a.cmc-table__column-name--name')
  if currencies.empty?
    puts "No currencies found"
    exit
  end
end

currencies = get_currencies(doc)

# getting the prices
def get_prices(doc)
  return prices = doc.css('span.sc-edc9a476-0')
  if prices.empty?
    puts "No currencies found"
    exit
  end
end

prices = get_prices(doc)

# array of hashes:
def crypto_array(currencies, prices)
  currencies_and_prices = currencies.map.with_index do |currency, i|
    {currency.text => prices[i].text}
  end
  return currencies_and_prices
end


currencies_and_prices = crypto_array(currencies, prices)
p currencies_and_prices


