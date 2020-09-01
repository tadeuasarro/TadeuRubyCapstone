class Filters
  attr_writer
  def initialize(start_date = nil, end_date = nil, language = nil)
    @start_date = start_date
    @end_date = end_date
    @language = language
  end

  def start_filtering
    if @start_date != nil && @end_date != nil
      # start filtering by the dates
      puts 'filtering by dates'
    elsif @language != nil
      #start filtering by the language
      puts 'filtering by languages'
    end
  end
end