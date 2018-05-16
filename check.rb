require 'open-uri'
require 'nokogiri'
# Checks and prints current Black Market Auction Items and Data
class Check
  class << self
    def current_auction
      Check.parse
      auction_item_data = Check.item_price.each_slice(8).to_a
      item_counter = 0
      while item_counter < auction_item_data.length
        puts "\nItem Name: #{Check.item_name(item_counter)}\n
         Current Bid: #{auction_item_data[item_counter][1]}
         Minimum Bid: #{auction_item_data[item_counter][2]}
         Time Left: #{auction_item_data[item_counter][3]}
         # of Bids: #{auction_item_data[item_counter][4]}
         Realm Market Value: #{auction_item_data[item_counter][5]}
         Global Market Value: #{auction_item_data[item_counter][6]}
         Realm AH Current Quantity: #{auction_item_data[item_counter][7]}\n"
        item_counter += 1
      end
    end

    def refresh
      # @doc = Nokogiri::HTML(open("https://www.tradeskillmaster.com/black-market?realm=US-area-52"))
      ##### Test file
      @doc = File.open('./spec/TSM_bmah_sample.xml') { |f| Nokogiri::XML(f) }
    end

    def parse
      Check.refresh

      puts "\nAuction House: #{@doc.xpath('//title').text}\n
      #{@doc.xpath('//div//p').children.first.text}\n
      Number of Items: #{@doc.xpath('//table//tbody//td//a').length}"
    end

    def item_price
      counter = 0
      item_price_collection = []
      until counter >= @doc.xpath('//table//tbody//td').length
        item_price_collection << @doc.xpath('//table//tbody//td')[counter].text
        counter += 1
      end
      item_price_collection
    end

    def item_name(entry)
      @doc.xpath('//table//tbody//td//a')[entry].attribute('title').text
    end
  end
end
