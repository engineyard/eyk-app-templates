class PollController < ApplicationController
    def index
        @poll = Poll.find(1)
        if params["answer"]
            @answer = Answer.new(params.require(:answer).permit(:choice))
            choice = Answer.find_by(item: @answer.choice)
            choice.count = choice.count + 1
            choice.save
        end
        @answers = Answer.all
    end

    def summary
        logger.info "In summary service"
        answers = Answer.all
        total_responses = 0
        most_popular_response = nil
        most_popular_response_count = 0
        least_popular_response = nil
        least_popular_response_count = 9999999  # an arbitrarily high number

        answer_data = {}
        answers.each do |answer|
            total_responses = total_responses + answer.count

            answer_data[answer.item] = answer.count 

            # Check if this is the most popular answer
            if answer.count > most_popular_response_count
                most_popular_response_count = answer.count
                most_popular_response = answer.item
            end 
            # Check if this is the least popular answer
            if answer.count < least_popular_response_count
                least_popular_response_count = answer.count
                least_popular_response = answer.item
            end 
        end
  
        response = {}
        response["number_of_responses"] = total_responses
        response["most_popular_response"] = most_popular_response
        response["least_popular_response"] = least_popular_response
        response["answers"] = answer_data
        render :json => JSON[response]
    end 
end
