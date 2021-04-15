AMOUNT_REWARD_POINTS = 50

class PollController < ApplicationController

    before_action :authenticate_user!

    def index
        # current_user is a helper added to controllers by Devise
        # It returns the user model object
        @user = current_user

        @poll = Poll.find(1)
        if params["reward"]
            reward = Reward.new(params.require(:reward).permit(:initial_choice, :reward_choice))
            @answer = Answer.new(choice: reward.initial_choice)

            # Query for the most popular answer
            most_popular = Answer.order("count DESC").first

            # Check whether the user selected the most popular choice
            @message = "You guessed '#{reward.reward_choice}' is the most popular choice.<br/><br/>"
            if reward.reward_choice == most_popular.item 
                @message = "#{@message}You were correct! You earned #{AMOUNT_REWARD_POINTS} reward points"
                points = Reward.new(user_id: @user.id, points: AMOUNT_REWARD_POINTS).save
            else 
                @message = "#{@message}Unfortunately, it turns out the most popular choice is '#{most_popular.item}'"
            end
            
        else
            ahoy.track "ViewHomePage", user_email: @user_email
        end

        @answers = Answer.all
        @comment = Comment.new(author_id: @user.id, article_id: 1)
        @all_comments = Comment.where(article_id: 1)
    end

    def submit
        @answer = Answer.new(params.require(:answer).permit(:choice))
        choice = Answer.find_by(item: @answer.choice)
        choice.count = choice.count + 1
        choice.save

        # Add an event for this page view
        ahoy.track "PollSubmit", user_email: @user_email

        # New feature to prompt user to earn rewards
        # Only use if the feature is turned on for the current user
        if $rollout.active?(:rewards, @user) 
            @reward = Reward.new(user_id: @user.id, initial_choice: @answer.choice)
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
