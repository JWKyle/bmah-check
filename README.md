# Black Market Auction House Checker
_WIP_

This is a tool to check what Black Market Auction House on Wow's Area-52 shard has to offer.  

Currently, I've worked through Nokogiri for scraping, and am implementing my TDD strategy.  Once TDD has been brought up to speed, the next steps will be to refactor and stylize.  

After the first Ruby iteration is operational, the next stages will involve turning the project into a CLI, then either building out (expanding to other shards) or building up (include other tools, like World Event timers, etc).

_This is currently only configured to work with Area 52_

Requirements:  
Nokogiri  
RSpec
HTTParty

Testing Strategy
Since this project initally undertaken to get re-aquainted with Nokogiri, the early code was tested directly through IRB.  However, as the project has outgrown the exploration phase, I'm incorperating RSpec for TDD.  

