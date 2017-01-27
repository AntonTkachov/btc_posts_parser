class PostsController < ApplicationController
  before_action :check_page_token_existence, :only => [:new]

  def new
  end

  def create
  end

  private
  def check_page_token_existence
    redirect_to new_token_path if Rails.application.secrets.page_access_token.nil?
  end

end