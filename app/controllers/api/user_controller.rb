class Api::UserController < ApplicationController
    before_action :authenticate_user!
  def index
      @alluser = User.all
    render json:  @alluser, status: 200
  end
end
