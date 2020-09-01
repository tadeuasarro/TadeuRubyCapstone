# /bin/main.rb

# rubocop:disable Metrics/MethodLength

require 'nokogiri'
require 'faraday'
require '../lib/result_array.rb'

def scraper
  unparsed_page = Faraday::Response.new

  loop do
    puts 'Enter a github username:'
    username = gets.chomp
    url = "https://github.com/#{username}?tab=repositories"
    unparsed_page = Faraday.get(url)
    break if unparsed_page.body != 'Not Found'

    puts 'User not found!!'
  end

  parsed_page = Nokogiri::HTML(unparsed_page.body)

  repo_listing = parsed_page.css('li.col-12')
  result_array = ResultArray.new
  result_array.retrieve_repos(repo_listing)

  total_repositories = parsed_page.css('span.Counter').text[0..1].to_i

  (total_repositories / 30).times do
    url = parsed_page.css('a.BtnGroup-item').map { |x| x['href'] }
    unparsed_page = Faraday.get(url[0].to_s)
    parsed_page = Nokogiri::HTML(unparsed_page.body)
    repo_listing = parsed_page.css('li.col-12')
    result_array.retrieve_repos(repo_listing)
  end

  result_array.display_repos
end

# rubocop:enable Metrics/MethodLength

scraper
