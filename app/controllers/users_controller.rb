class UsersController < ApplicationController

  def index

  end

  def login
    @user = User.koala(request.env['omniauth.auth']['credentials'])
    @user_token = request.env['omniauth.auth']['credentials']['token']
    get_token_of_page
  end

  private

  def get_token_of_page
    @graph = Koala::Facebook::API.new(@user_token)
    @page_token = @graph.get_connections("me", "accounts").first['access_token']

  end

end