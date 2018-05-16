require 'open-uri'
require 'nokogiri'
class Check

  def self.refresh
    # @doc = Nokogiri::HTML(open("https://www.tradeskillmaster.com/black-market?realm=US-area-52")) Commented out for testing
    @doc = File.open("./spec/TSM_bmah_sample.xml") { |f| Nokogiri::XML(f) } #Test file
  end

  def self.parse
    Check.refresh
    auction_house = @doc.xpath("//title").text
    updated_at = @doc.xpath("//div//p").children.first.text
    column_label = @doc.xpath("//thead//tr").text
    item_name = @doc.xpath("//table//tbody").children.children.children.attribute("title").text
    number_of_entries = @doc.xpath("//table//tbody/tr/@data-key").children.text.length # counts the number of datakeys, such a number of entries.

    puts "Auction House: #{auction_house}"
    puts "#{updated_at}"
    puts "Columns: #{column_label}"
    puts "Number of Items: #{number_of_entries}"
    puts "Item Name: #{item_name}"
  end

  def self.price_index
    counter = 0
    until counter >= @doc.xpath("//table//tbody").children.length
      puts @doc.xpath("//table//tbody").children[counter].text
      counter += 1
    end
  end

  def self.price_builder
    # price builder will take the first 8 elements of an array and create a new array from them, then puts each item out with the label
    each_item_prices = Check.item_price.each_slice(8).to_a
    p each_item_prices
    item_counter = 0
    while item_counter < each_item_prices.length
      puts "\nItem Name: #{Check.item_name(item_counter)}\n
       Current Bid: #{each_item_prices[item_counter][1]}
       Minimum Bid: #{each_item_prices[item_counter][2]}
       Time Left: #{each_item_prices[item_counter][3]}
       # of Bids: #{each_item_prices[item_counter][4]}
       Realm Market Value: #{each_item_prices[item_counter][5]}
       Global Market Value: #{each_item_prices[item_counter][6]}
       Realm AH Current Quantity: #{each_item_prices[item_counter][7]}\n"
      item_counter += 1
    end
  end

private

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
