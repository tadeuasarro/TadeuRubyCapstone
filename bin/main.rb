# /bin/main.rb

require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
  url = 'https://github.com/tadeuasarro?tab=repositories'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  repo_listing = parsed_page.css('li.col-12')
  result_array = []
  repo_listing.each do |i|
    repo = {
      repo_name: i.css('h3.wb-break-all').text.to_s.gsub("\n", '').gsub(' ', ''),
      last_update: i.css('relative-time.no-wrap').text
    }
    puts repo
  end
  # byebug
end
scraper
