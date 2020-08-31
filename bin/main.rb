# /bin/main.rb

require 'nokogiri'
require 'open-uri'

# Fetch and parse HTML document
doc = Nokogiri::HTML(URI.open('https://tadeuasarro.web.app'))

puts '### Search for nodes by css'
doc.css('nav ul.menu li a', 'article h2').each do |link|
  puts link.content
end
