class FacebookAPI
  class << self
    def create_new_graph_api(page_token)
      Koala::Facebook::API.new(page_token)
    end

    def get_token_of_page(user_token)
      create_new_graph_api(user_token).get_connections("me", "accounts").first['access_token']
    end

    def publish_post_by_schedule(page_token, text, time)
      create_new_graph_api(page_token).put_wall_post(text, {published: false, scheduled_publish_time: time})
    end

    def publish_post_immediately(page_token, text)
      create_new_graph_api(page_token).put_wall_post(text)
    end
  end
end