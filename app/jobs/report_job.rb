class ReportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Creating instant poll report ..."

    Poll.all.each do |poll|
      puts "Poll: #{poll.name}"
      choices = Answer.where(poll_id: poll.id)
      total_respondents = 0
      choices.each do |choice|
        total_respondents = total_respondents + choice.count
        puts "#{choice.item}:  #{choice.count}"
      end
      puts "----------------------------"
      puts "Number of respondents: #{total_respondents}"      
    end
    puts "Done creating report."
  end
end
