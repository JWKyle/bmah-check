require './check'
require 'open-uri'
require 'nokogiri'

RSpec.describe Check do
  # @doc = File.open("./spec/TSM_bmah_sample.html") { |f| Nokogiri::HTML(f) }
  describe "#parse" do
    it "Shows the title of the Auction House" do
      expect(Check.parse).to eq("Black Market Auction House - Area 52 (US)")
    end
  end
  describe "#price_builder" do
    it "Shows the first item for bid" do

      expect(Check.price_builder::each_item_prices[item_counter][0]).to eq("")
    end
  end
  describe "#price_builder" do
    it "Shows printout of bidding information" do
      expect(Check.price_builder).to eq("")
    end
  end
end
