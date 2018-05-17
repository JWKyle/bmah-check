require 'dotenv/load'
require 'httparty'
# Pulls Wow Token price info
class Token
  class << self
    def refresh
      url = 'https://us.api.battle.net/data/wow/token/?namespace=dynamic-us&locale=en_US&access_token=' + ENV['WOW_ACCESS_TOKEN']
      response = HTTParty.get(url)
      token_price = response.parsed_response["price"]
      (token_price / 10000).to_s + 'g'
    end

    def format
      Token.refresh.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    end
  end
end
