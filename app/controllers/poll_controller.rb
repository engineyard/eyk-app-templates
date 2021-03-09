class PollController < ApplicationController
    def index
        if params["poll"]
            @choice = Poll.new(params.require(:poll).permit(:choice))
            choice = Poll.find_by(item: @choice.choice)
            choice.count = choice.count + 1
            choice.save
        end
        @choices = Poll.all
    end
end
