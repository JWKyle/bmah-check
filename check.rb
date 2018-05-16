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
    counter = 0
    until counter >= @doc.xpath("//table//tbody//td").children.length
      
  end

end
