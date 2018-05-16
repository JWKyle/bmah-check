require 'open-uri'
require 'nokogiri'
class Check

  def self.refresh
    # @doc = Nokogiri::HTML(open("https://www.tradeskillmaster.com/black-market?realm=US-area-52")) Commented out for testing
    @doc = File.open("./spec/TSM_bmah_sample.html") { |f| Nokogiri::HTML(f) } #Test file
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
      puts
      puts "Item Name: #{each_item_prices[item_counter][0]}"
      puts "Current Bid: #{each_item_prices[item_counter][1]}"
      puts "Minimum Bid: #{each_item_prices[item_counter][2]}"
      puts "Time Left: #{each_item_prices[item_counter][3]}"
      puts "# of Bids: #{each_item_prices[item_counter][4]}"
      puts "Realm Market Value: #{each_item_prices[item_counter][5]}"
      puts "Global Market Value: #{each_item_prices[item_counter][6]}"
      puts "Realm AH Current Quantity: #{each_item_prices[item_counter][7]}"
      puts
      item_counter += 1
    end
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

end
