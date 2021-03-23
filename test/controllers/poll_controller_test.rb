require "test_helper"

class PollControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers 

    test "view poll" do
        # Use the sign_in helper to sign in a fixture `User` record.
        sign_in users(:yahoo)

        get '/poll/index'

        assert_match "What is your favorite weekend activity", @response.body
        assert_response :success
    end

end
