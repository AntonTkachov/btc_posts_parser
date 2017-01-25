class FacebookAPI
  class << self

    def get_token_of_page(user_token)
      Koala::Facebook::API.new(user_token).get_connections("me", "accounts").first['access_token']
    end

  end
end