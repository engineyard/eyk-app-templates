class PollController < ApplicationController
  
  def load_data
      @choices = Poll.all
      if params["poll"]
          @choice = Poll.new(params.require(:poll).permit(:choice))
      else
          @choice = nil
      end
  end

  def index
      load_data
      if @choice
          logger.info "The user choice was #{@choice.choice}"
          choice = Poll.find_by(item: @choice.choice)
          choice.count = choice.count + 1
          choice.save
          @choices = Poll.all
      else
          @choice = Poll.new
      end
  end
end
