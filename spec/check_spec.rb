require './check'
require 'open-uri'
require 'nokogiri'

RSpec.describe Check do
  # @doc = File.open("./spec/TSM_bmah_sample.html") { |f| Nokogiri::HTML(f) }
  describe "#parse" do
    pending "Shows the title of the Auction House" do
      expect(Check.parse).to eq("Black Market Auction House - Area 52 (US)")
    end
  end
  describe "#current_auction" do
    pending "Shows the first item for bid" do
      expect(Check.current_auction::auction_item_data[item_counter][0]).to eq("")
    end

    pending "Shows printout of bidding information" do
      expect(Check.current_auction).to eq("")
    end
  end
end
