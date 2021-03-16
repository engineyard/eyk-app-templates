class PollController < ApplicationController

    before_action :authenticate_user!

    def index
        # TODO Devise testing
        puts "User signed in: #{user_signed_in?}"
        if user_signed_in?
            my_user = current_user 
            my_session = user_session
            puts "My user: #{current_user.inspect}"
            puts "My session: #{my_session.inspect}"
        end 

        @poll = Poll.find(1)
        if params["answer"]
            @answer = Answer.new(params.require(:answer).permit(:choice))
            choice = Answer.find_by(item: @answer.choice)
            choice.count = choice.count + 1
            choice.save
        end
        @answers = Answer.all
    end

    def report 
        puts "Run the report"
        @poll = Poll.find(1)
        @answers = Answer.all
        
        # Native Sidekiq
        #ReportWorker.perform_async
        # Sidekiq using ActiveJobs
        ReportJob.perform_later

        render 'index'
    end 
end
