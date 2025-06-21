require "application_system_test_case"

class HomePagesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_url

    assert_selector "strong", text: "Rails"
  end
end
