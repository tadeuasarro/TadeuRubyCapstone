class ResultArray < Array

  def retrieve_repos(repo_listing)
    repo_listing.each do |i|
      repo = {
        repo_name: i.css('h3.wb-break-all').text.to_s.gsub("\n", '').gsub(' ', ''),
        last_update: i.css('relative-time.no-wrap').text,
        lang_used: i.css('span.ml-0').text.to_s.gsub("\n", '').gsub(' ', ''),
        star_number: i.css('a.muted-link').text.to_s.gsub("\n", '').gsub(' ', '')
      }
      self << repo
    end
    self
  end

  def display_repos
    puts "Total repositories found: #{self.count}"
    self.length.times do |i|
      puts '----------------'
      puts "Repository name: #{self[i][:repo_name]}."
      puts "Last updated: #{self[i][:last_update]}."
      puts self[i][:lang_used].to_s.length.zero? ? 'Language used: Not available' : "Language used: #{self[i][:lang_used]}." ;
      puts "Number of stars: #{self[i][:star_number]}."
    end
  end
end