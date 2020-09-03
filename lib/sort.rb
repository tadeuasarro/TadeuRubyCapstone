# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

require 'date'
require_relative '../lib/result_array.rb'

class Sort
  def initialize(result_array = ResultArray)
    @result_array = result_array
  end

  def check_sort_input
    answer = ''
    loop do
      puts 'Choose the selected sort from below:'
      puts 'Available sorting methods:'
      puts '0 -- No sorting'
      puts '1 -- Date sorting'
      puts '2 -- Language sorting'
      puts '3 -- Stars number sorting'
      answer = gets.chomp.to_i
      break if [0, 1, 2, 3].include?(answer)

      puts 'Invalid input. Please, try again.'
    end
    @input = answer
    check_sort
  end

  private

  def check_sort
    case @input
    when 0
      puts 'No sorting were added.'
    when 1
      @option = 0
      loop do
        puts 'Sorting by date.'
        puts 'Choose:'
        puts '1 -- Ascending'
        puts '2 -- Descending'
        @option = gets.chomp.to_i
        break if @option == 2 || @option == 1

        puts 'Invalid input!'
      end
      sort_by_date
    when 2
      @option = 0
      loop do
        puts 'Sorting by language.'
        puts 'Choose:'
        puts '1 -- Ascending'
        puts '2 -- Descending'
        @option = gets.chomp.to_i
        break if @option == 2 || @option == 1

        puts 'Invalid input!'
      end
      sort_by_language
    when 3
      @option = 0
      loop do
        puts 'Sorting by stars numbers.'
        puts 'Choose:'
        puts '1 -- Ascending'
        puts '2 -- Descending'
        @option = gets.chomp.to_i
        break if @option == 2 || @option == 1

        puts 'Invalid input!'
      end
      sort_by_stars
    end
  end

  def sort_by_date
    if @option == 1
      @result_array.sort! { |x, y| Date.parse(x[:last_update]) <=> Date.parse(y[:last_update]) }
    else
      @result_array.sort! { |x, y| Date.parse(y[:last_update]) <=> Date.parse(x[:last_update]) }
    end
    @result_array
  end

  def sort_by_language
    if @option == 1
      @result_array.sort! { |x, y| x[:lang_used] <=> y[:lang_used] }
    else
      @result_array.sort! { |x, y| y[:lang_used] <=> x[:lang_used] }
    end
    @result_array
  end

  def sort_by_stars
    if @option == 1
      @result_array.sort! { |x, y| x[:star_number].to_i <=> y[:star_number].to_i }
    else
      @result_array.sort! { |x, y| y[:star_number].to_i <=> x[:star_number].to_i }
    end
    @result_array
  end
end

# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
