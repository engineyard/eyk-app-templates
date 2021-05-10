require 'services'

class CommentController < ApplicationController
  def submit
    new_comment = Comment.new(params.require(:comment).permit(:comment_text,
                                                              :article_id,
                                                              :author_id))
    service_result = CommentOnArticle.call(new_comment)

    if service_result.failure?
      puts "The service failed: #{service_result.inspect}"
      @message = service_result.message
    else
      puts "The service succeeded: #{service_result.inspect}"
      if service_result.feedback 
        @message = service_result.feedback
      end
    end

    # Load data for the view component
    @comment = Comment.new(author_id: @user_id, article_id: 1)
    @all_comments = Comment.where(article_id: 1)
    
    render(partial: "comment/view")
  end
end
