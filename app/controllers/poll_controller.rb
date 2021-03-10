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
end
