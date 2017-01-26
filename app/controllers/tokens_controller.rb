class TokensController < ApplicationController

  def new
  end

  def create
    Rails.application.secrets.page_access_token = FacebookAPI.get_token_of_page(request.env['omniauth.auth']['credentials']['token'])
    redirect_to new_post_path
  end

end