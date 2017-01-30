class FacebookAPI
  def initialize(page_token)
    @client = Koala::Facebook::API.new(page_token)
  end

  def get_token_of_page
    @client.get_connections("me", "accounts").find(Rails.application.secrets.page_id).first['access_token']
  end

  def publish_post_by_schedule(text, time)
    @client.put_wall_post(text, {published: false, scheduled_publish_time: time})
  end

  def publish_post_immediately(text)
    @client.put_wall_post(text)
  end
end