class MainController < ApplicationController
    before_action :require_login, only: [:index]
  
    def index
      @posts = Post.all
    end
  end
  