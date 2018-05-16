require 'open-uri'
require 'nokogiri'
class Check

  def self.refresh
    @doc = Nokogiri::XML(open("https://www.tradeskillmaster.com/black-market?realm=US-area-52"))
  end

  def self.parse
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
    Array.new << Check.item_price.slice!(0..7)
    # counter = 0
    # price_collection = []
    # until counter >= @doc.xpath("//table//tbody//td").children.length
    #   price_collection << @doc.xpath("//table//tbody//td").children[counter].text
    #   counter += 1
    # end
    # price_collection
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
