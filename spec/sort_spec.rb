# spec/sort_spec.rb

require 'date'
require 'nokogiri'
require 'faraday'
require './lib/sort'

unparsed_page = Faraday.get('https://github.com/tadeuasarro?tab=repositories')
parsed_page = Nokogiri::HTML(unparsed_page.body)
result_array = ResultArray.new
repo_listing = parsed_page.css('li.col-12')

describe Sort do
  describe '#sort_by_date' do
    it 'Returns the array after being sorted according to the date' do
      result_array.retrieve_repos(repo_listing)
      sort = Sort.new(result_array)
      sort.option = 1
      sort.sort_by_date
      expect(Date.parse(result_array[0][:last_update]) <= Date.parse(result_array[1][:last_update])).to eql(true)
    end
  end
  describe '#sort_by_language' do
    it 'Returns the array after being sorted according to the programming language' do
      result_array.retrieve_repos(repo_listing)
      sort = Sort.new(result_array)
      sort.option = 1
      sort.sort_by_language
      expect(result_array[4][:lang_used] <= result_array[5][:lang_used]).to eql(true)
    end
  end
  describe '#sort_by_stars' do
    it 'Returns the array after being sorted according to the number of stars' do
      result_array.retrieve_repos(repo_listing)
      sort = Sort.new(result_array)
      sort.option = 1
      sort.sort_by_stars
      expect(result_array[0][:star_number] <= result_array[1][:star_number]).to eql(true)
    end
  end
end
