class PollController < ApplicationController

    before_action :authenticate_user!

    def index
        # current_user is a helper added to controllers by Devise
        # It returns the user model object
        @user_email = current_user.email 


        @poll = Poll.find(1)
        if params["answer"]
            @answer = Answer.new(params.require(:answer).permit(:choice))
            choice = Answer.find_by(item: @answer.choice)
            choice.count = choice.count + 1
            choice.save

            # Add an event for this page view
            ahoy.track "PollSubmit", user_email: @user_email
        else
            ahoy.track "ViewHomePage", user_email: @user_email
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
