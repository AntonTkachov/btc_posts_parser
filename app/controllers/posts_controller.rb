class PostsController < ApplicationController
  before_action :require_page_token

  def new
  end

  def create
    client = FacebookAPI.new(Rails.application.secrets.page_access_token)
    flash[:message] = client.publish_post(post_params[:text], Time.new(*time_parsing(post_params[:time])).to_i)
    redirect_to new_post_path
  end

  def get_news
    @news_html = ForklogParser.html(news_params[:link])
    redirect_to posts_get_news_path
  end

  private
  def require_page_token
    redirect_to new_token_path if Rails.application.secrets.page_access_token.nil?
  end

  def post_params
    params.require(:post).permit(:text, :time)
  end

  def news_params
    params.require(:news).permit(:link)
  end

  def time_parsing(string)
    string.gsub('/', ' ').gsub(':', ' ').split.map { |el| el.to_i }
  end

end