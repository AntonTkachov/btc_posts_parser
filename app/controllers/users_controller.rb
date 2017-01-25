class UsersController < ApplicationController

  def index

  end

  def login
    @user_token = request.env['omniauth.auth']['credentials']['token']
    @page_token = FacebookAPI.get_token_of_page(@user_token)
  end

end