require "test_helper"
require "capybara/playwright"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :playwright
end
