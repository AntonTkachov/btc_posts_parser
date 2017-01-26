class TokensController < ApplicationController

  def new
  end

  def create
    Rails.application.secrets.access_token = FacebookAPI.get_token_of_page(request.env['omniauth.auth']['credentials']['token'])
  end

end