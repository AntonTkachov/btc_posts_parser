class TokensController < ApplicationController
  def new
  end

  def create
    Rails.application.secrets.page_access_token = FacebookAPI.new(request.env['omniauth.auth']['credentials']['token']).get_token_of_page
    if Rails.application.secrets.page_access_token.nil?
      flash[:message] = "Something went wrong. Token wasn't saved"
      redirect_to new_token_path
    else
      flash[:message] = "Token was received and saved"
      redirect_to new_post_path
    end
  end

  private
  def news_params
    params.require(:news).permit(:link)
  end
end