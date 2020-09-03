# spec/filters_spec.rb

require 'date'
require 'nokogiri'
require 'faraday'
require_relative '../lib/filters'

unparsed_page = Faraday.get('https://github.com/tadeuasarro?tab=repositories')
parsed_page = Nokogiri::HTML(unparsed_page.body)
result_array = ResultArray.new
repo_listing = parsed_page.css('li.col-12')

describe Filters do
  describe '#filter_by_date' do
    it 'Returns the array after being modified with the select! method and the dates attributes' do
      result_array.retrieve_repos(repo_listing)
      filter = Filters.new(result_array)
      filter.start_date = '01/07/2020'
      filter.end_date = '01/08/2020'
      filter.filter_by_date
      expect(result_array.length).to eql(5)
    end
  end
  describe '#filter_by_language' do
    it 'Returns the array after being modified with the select! method and the language attribute' do
      result_array.retrieve_repos(repo_listing)
      filter = Filters.new(result_array)
      filter.language = 'ruby'
      filter.filter_by_language
      expect(result_array.length).to eql(2)
    end
  end
  describe '#filter_by_both' do
    it 'Returns the array after being modified with the select! method and the dates and language attributes' do
      result_array.retrieve_repos(repo_listing)
      filter = Filters.new(result_array)
      filter.start_date = '01/07/2020'
      filter.end_date = '01/08/2020'
      filter.language = 'html'
      filter.filter_by_both
      expect(result_array.length).to eql(3)
    end
  end
end
