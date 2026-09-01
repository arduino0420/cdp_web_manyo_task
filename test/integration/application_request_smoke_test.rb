require "test_helper"

class ApplicationRequestSmokeTest < ActionDispatch::IntegrationTest
  test "serves the public error page through the application stack" do
    get "/404.html"

    assert_response :success
    assert_includes response.body.force_encoding("UTF-8"), "お探しのページは見つかりません。"
  end
end