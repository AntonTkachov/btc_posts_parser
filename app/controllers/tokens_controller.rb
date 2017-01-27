class TokensController < ApplicationController

  def new
  end

  def create
    Rails.application.secrets.page_access_token = FacebookAPI.get_token_of_page(request.env['omniauth.auth']['credentials']['token'])
    if Rails.application.secrets.page_access_token.nil?
      flash[:message] = "Something went wrong. Token wasn't saved"
      redirect_to new_token_path
    else
      flash[:message] = "Token was received and saved"
      redirect_to new_post_path
    end
  end

end