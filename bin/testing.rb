
require 'nokogiri'
require 'faraday'
require '../lib/filters.rb'
require '../lib/sort.rb'

unparsed_page = Faraday.get('https://github.com/tadeuasarro?tab=repositories')
parsed_page = Nokogiri::HTML(unparsed_page.body)
result_array = ResultArray.new
repo_listing = parsed_page.css('li.col-12')


result_array.retrieve_repos(repo_listing)
sort = Sort.new(result_array)
sort.option = 1
expect(result_array[0][:star_number] <= result_array[1][:star_number]).to eql(true)