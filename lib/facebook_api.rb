class FacebookAPI
  def initialize(page_token)
    @client = Koala::Facebook::API.new(page_token)
  end

  def get_token_of_page
    @client.get_connections("me", "accounts").find(Rails.application.secrets.page_id).first['access_token']
  end

  def publish_post(text, time)
    if time > (Time.now + 600).to_i
      @client.put_wall_post(text, {published: false, scheduled_publish_time: time})
      message = 'Your post will be published at the scheduled time'
    else
      @client.put_wall_post(text)
      message = 'Your post is published'
    end
    message
  end
end