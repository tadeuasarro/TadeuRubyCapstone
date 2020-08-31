# /bin/main.rb

# rubocop:disable Metrics/MethodLength

require 'nokogiri'
require 'faraday'

def retrieve_repo(repo_listing, result_array)
  repo_listing.each do |i|
    repo = {
      repo_name: i.css('h3.wb-break-all').text.to_s.gsub("\n", '').gsub(' ', ''),
      last_update: i.css('relative-time.no-wrap').text
    }
    result_array << repo
  end
  result_array
end

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
  result_array = []
  retrieve_repo(repo_listing, result_array)

  total_repositories = parsed_page.css('span.Counter').text[0..1].to_i

  (total_repositories / 30).times do
    url = parsed_page.css('a.BtnGroup-item').map { |x| x['href'] }
    unparsed_page = Faraday.get(url[0].to_s)
    parsed_page = Nokogiri::HTML(unparsed_page.body)
    repo_listing = parsed_page.css('li.col-12')
    retrieve_repo(repo_listing, result_array)
  end

  puts result_array
end

# rubocop:enable Metrics/MethodLength

scraper
