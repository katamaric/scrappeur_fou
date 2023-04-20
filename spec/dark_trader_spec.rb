require_relative '../lib/dark_trader'
require 'nokogiri'
require 'open-uri'

RSpec.describe "#get_currencies" do
  let(:doc) { Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/')) }

  it "returns an array of currency names" do
    currencies = get_currencies(doc)
    expect(currencies).to eq(doc.css('a.cmc-table__column-name--name'))
  end

  it "includes Dogecoin in the array" do
    currencies = get_currencies(doc)
    expect(currencies.map(&:text)).to include("Dogecoin")
  end
end
