require 'open-uri'
class Check

  def refresh
    @doc = Nokogiri::XML(open("https://www.tradeskillmaster.com/black-market?realm=US-area-52"))
  end

  def parse
    column_label = @doc.xpath("//thead//tr").text
  end

end
