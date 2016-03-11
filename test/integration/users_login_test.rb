require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  test "invalid log in attempt" do
    get login_path
    assert_template 'sessions/new'
    post_via_redirect login_path, session: { email: "user@invalid", password: " " }
    assert_template 'sessions/new'
    get root_path
    assert flash.empty?
  end

end
