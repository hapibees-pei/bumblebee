require 'devise/jwt/test_helpers'

module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def authenticated_header(user)
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
  end
end