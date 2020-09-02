# rubocop:disable Metrics/MethodLength

require 'date'
require_relative '../lib/result_array.rb'

class Filters
  attr_accessor :start_date, :end_date, :language, :input

  def initialize(result_array = ResultArray)
    @result_array = result_array
  end

  def check_filter_input
    answer = ''
    loop do
      puts 'Choose the selected filter from below:'
      puts 'Available filters:'
      puts '0 -- No filter'
      puts '1 -- Date filter'
      puts '2 -- Language filter'
      puts '3 -- Both filters'
      answer = gets.chomp.to_i
      break if [0, 1, 2, 3].include?(answer)

      puts 'Incorrect input. Please, try again.'
    end
    self.input = answer
    check_filter
  end

  def check_filter
    case input
    when 0
      puts 'No filters were added.'
    when 1
      key = false
      while key == false
        puts 'Filtering by date.'
        loop do
          puts 'Input a start date [YYYY-MM-DD]:'
          self.start_date = gets.chomp
          break if date_validator(self.start_date)
          puts 'Invalid date!'
        end
        loop do
          puts 'Input an end date [YYYY-MM-DD]:'
          self.end_date = gets.chomp
          break if date_validator(self.end_date)
          puts 'Invalid date!'
        end
        key = filter_by_date
      end
    when 2
      puts 'Filtering by language.'
      puts 'Input the choosen language:'
      self.language = gets.chomp
      filter_by_language
    when 3
      puts 'Filtering by both.'
      puts 'Input a start date [YYYY-MM-DD]:'
      self.start_date = gets.chomp
      puts 'input a end date [YYYY-MM-DD]:'
      self.end_date = gets.chomp
      puts 'Input the choosen language:'
      self.language = gets.chomp
      filter_by_both
    end
  end

  def date_validator(validating_argument)
    begin
      Date.parse(validating_argument)
    rescue
      false
    end
  end

  def filter_by_date
    if Date.parse(start_date) > Date.parse(end_date)
      puts 'Check the dates input please!'
      return false
    end
    @result_array.select! do |x|
      Date.parse(x[:last_update]) > Date.parse(start_date) && Date.parse(x[:last_update]) < Date.parse(end_date)
    end
    @result_array
  end

  def filter_by_language
    @result_array.select! do |x|
      (x[:lang_used]).downcase == language.downcase
    end
    @result_array
  end

  def filter_by_both
    if Date.parse(start_date) > Date.parse(end_date)
      puts 'Check the dates input please!'
      return false
    end
    @result_array.select! do |x|
      Date.parse(x[:last_update]) > Date.parse(start_date) && Date.parse(x[:last_update]) < Date.parse(end_date)
    end
    @result_array.select! do |x|
      (x[:lang_used]).downcase == language.downcase
    end
    @result_array
  end
end

# rubocop:enable Metrics/MethodLength
