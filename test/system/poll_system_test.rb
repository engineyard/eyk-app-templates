require "application_system_test_case"

class PollsTest < ApplicationSystemTestCase
    include Devise::Test::IntegrationHelpers 
   
    #test "view the poll" do
    #    sign_in users(:yahoo)

    #    visit '/poll/index'
    #    assert_selector "h3", text: "What is your favorite weekend activity"
    #end

    test "answer the poll" do
        sign_in users(:yahoo)

        visit '/poll/index'

        choose('Gaming')
        click_button "Vote"
        assert_selector "div", text: "Gaming: 1"
     end
end
