require 'test_helper'

class ChatControllerTest < ActionDispatch::IntegrationTest
  test "block access to chat if user online is more than 0" do
      get chat_path
      assert_redirected_to root_path
  end
end
