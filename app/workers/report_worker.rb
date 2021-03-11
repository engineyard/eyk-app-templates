class ReportWorker
  include Sidekiq::Worker

  # Per Sidekiq documentation, your perform method arguments must be simple,
  # basic types like String, integer, boolean that are supported by JSON.
  # Complex Ruby objects will not work.
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
