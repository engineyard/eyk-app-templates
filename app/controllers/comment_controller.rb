class CommentController < ApplicationController
  def submit
    new_comment = Comment.new(params.require(:comment).permit(:comment_text, :article_id, :author_id))
    new_comment.save

    @comment = Comment.new(author_id: @user_id, article_id: 1)
    @all_comments = Comment.where(article_id: 1)
    
    puts "Comment submit, we found #{@all_comments.size} existing comments"
    render(partial: "comment/view")
  end
end
