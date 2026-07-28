require "application_system_test_case"

class ApplicationSystemSmokeTest < ApplicationSystemTestCase
  driven_by :rack_test

  test "renders the public error page" do
    visit "/404.html"

    assert_text "The page you were looking for doesn't exist."
  end
end
