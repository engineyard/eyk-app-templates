require 'light-service'
require 'textmood'

class CommentOnArticle
    extend LightService::Organizer
  
    def self.call(comment)
        with(:comment => comment).reduce(
            ModerateCommentAction,
            AnalyzeSentimentAction,
            AddCommentAction
        )
    end
end

class ModerateCommentAction
    extend LightService::Action
    expects :comment

    executed do |context|
        # A made-up validation to demonstrate validation for disallowed content
        if context.comment.comment_text.include? "bad_word"
            context.fail!("Sorry, your comment was not allowed based on the content.",
                          error_code: 100)   # The error code is optional and arbitrary
        end
    end
end

class AnalyzeSentimentAction
    extend LightService::Action
    expects :comment
    promises :sentiment_score, :feedback
  
    executed do |context|
        tm = TextMood.new(language: "en", normalize_score: true)
        context.sentiment_score = tm.analyze(context.comment.comment_text)
        if context.sentiment_score < -50
            context.feedback = "Thanks for your comment (#{context.sentiment_score}). \
                                Please let us know what we can do to improve our content."
        elsif context.sentiment_score > 50
            context.feedback = "Thanks for your comment (#{context.sentiment_score}) \
                                and the positive energy!"
        else 
            context.feedback = "Thanks for your comment (#{context.sentiment_score})."
        end      
    end
end

class AddCommentAction
    extend LightService::Action
    expects :comment
  
    executed do |context|
        puts "Saving the comment to the database in AddCommentAction"
        context.comment.save
    end
end