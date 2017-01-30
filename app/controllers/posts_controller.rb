class PostsController < ApplicationController
  before_action :require_page_token

  def new
  end

  def create
    @client = FacebookAPI.new(Rails.application.secrets.page_access_token)
    if Time.new(*time_parsing(post_params[:time])).to_i > (Time.now + 600).to_i
      @client.publish_post_by_schedule(post_params[:text], Time.new(*time_parsing(post_params[:time])).to_i)
      flash[:message] = 'Your post will be published at the scheduled time'
    else
      @client.publish_post_immediately(post_params[:text])
      flash[:message] = 'Your post is published'
    end
    redirect_to new_post_path
  end

  private
  def require_page_token
    redirect_to new_token_path if Rails.application.secrets.page_access_token.nil?
  end

  def post_params
    params.require(:post).permit(:text, :time)
  end

  def time_parsing(string)
    string.gsub('/', ' ').gsub(':', ' ').split.map { |el| el.to_i }
  end

end