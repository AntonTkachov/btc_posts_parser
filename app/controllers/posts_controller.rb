class PostsController < ApplicationController
  before_action :require_page_token

  def new
  end

  def create
    client = FacebookAPI.new(Rails.application.secrets.page_access_token)
    flash[:message] = client.publish_post(parse_news(post_params[:link]), Time.new(*time_parsing(post_params[:time])).to_i, post_params[:link])
    redirect_to new_post_path
  end

  private
  def require_page_token
    redirect_to new_token_path if Rails.application.secrets.page_access_token.nil?
  end

  def post_params
    params.require(:post).permit(:link, :time)
  end

  def time_parsing(string)
    string.gsub('/', ' ').gsub(':', ' ').split.map { |el| el.to_i }
  end

  def parse_news(link)
    case link
    when /forklog\.com/
      ForklogParser.parse_news(link)
    when /bits\.media/
      BitsMediaParser.parse_news(link)
    when /bitnovosti\.com/
      BitnovostiParser.parse_news(link)
    when /coinspot\.io/
      CoinspotParser.parse_news(link)
    when /invest-rating\.ru/
      InvestRatingParser.parse_news(link)
    end
  end
end