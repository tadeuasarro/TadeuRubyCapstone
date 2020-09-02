# spec/result_array_spec.rb

require './lib/result_array'
require 'nokogiri'
require 'faraday'
require 'date'

unparsed_page = Faraday.get("https://github.com/tadeuasarro?tab=repositories")
parsed_page = Nokogiri::HTML(unparsed_page.body)
result_array = ResultArray.new
repo_listing = parsed_page.css('li.col-12')
result_array.retrieve_repos(repo_listing)

describe ResultArray do
  describe "#retrieve_repos" do
    it "Retrieves the repositories from the github webpage in an array" do
      expect(result_array.class).to eql(ResultArray)
    end
    it "The array retrieved is supposed to have 13 indexes" do
      expect(result_array.length).to eql(13)
    end
    it "Inside of each index there is an hash" do
      expect(result_array[0].class).to eql(Hash)
    end
    it "The first key should return a string with the name of the repository" do
      expect(result_array[0][:repo_name].class).to eql(String)
    end
    it "The second key should return a string, which can be converted to a valid date format" do
      expect(Date.parse(result_array[0][:last_update]).class).to eql(Date)
    end
    it "The third key should return a string with the name of the programming language used" do
      expect(result_array[0][:lang_used].class).to eql(String)
    end
    it "The fourth key should return a string that can be converted into a integer (amount of stars)" do
      expect(result_array[1][:star_number].to_i.class).to eql(Integer)
    end
  end

  describe "#display_repos" do
    it "Does something" do
    end
  end
end