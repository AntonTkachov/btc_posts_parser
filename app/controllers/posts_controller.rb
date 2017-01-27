class PostsController < ApplicationController
  before_action :check_page_token_existence, :only => [:new]

  def new
  end

  def create
    if Time.new(*time_parsing(post_params[:time])).to_i > (Time.now + 600).to_i
      FacebookAPI.publish_post_by_schedule(Rails.application.secrets.page_access_token, post_params[:text], Time.new(*time_parsing(post_params[:time])).to_i)
      flash[:message] = 'Your post will be published at the scheduled time'
    else
      FacebookAPI.publish_post_immediately(Rails.application.secrets.page_access_token, post_params[:text])
      flash[:message] = 'Your post is published'
    end
    redirect_to new_post_path
  end

  private
  def check_page_token_existence
    redirect_to new_token_path if Rails.application.secrets.page_access_token.nil?
  end

  def post_params
    params.require(:post).permit(:text, :time)
  end

  def time_parsing(string)
    string.gsub('/', ' ').gsub(':', ' ').split.map { |el| el.to_i }
  end

end