require 'open-uri'
require 'nokogiri'
class Check

  def self.current_auction
    Check.parse
    # price builder will take the first 8 elements of an array and create a new array from them, then puts each item out with the label
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

private

  def self.refresh
    # @doc = Nokogiri::HTML(open("https://www.tradeskillmaster.com/black-market?realm=US-area-52")) #Commented out for testing
    @doc = File.open("./spec/TSM_bmah_sample.xml") { |f| Nokogiri::XML(f) } #Test file
  end

  def self.parse
    Check.refresh
    auction_house = @doc.xpath("//title").text
    updated_at = @doc.xpath("//div//p").children.first.text
    number_of_entries = @doc.xpath("//table//tbody//td//a").length

    puts "\nAuction House: #{auction_house}\n
    #{updated_at}\n
    Number of Items: #{number_of_entries}"
  end

  def self.item_price
    counter = 0
    item_price_collection = []
    until counter >= @doc.xpath("//table//tbody//td").length
      item_price_collection << @doc.xpath("//table//tbody//td")[counter].text
      counter += 1
    end
    item_price_collection
  end

  def self.item_name(entry)
    @doc.xpath("//table//tbody//td//a")[entry].attribute("title").text
  end
end
