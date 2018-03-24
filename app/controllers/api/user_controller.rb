class Api::UserController < ApplicationController
    before_action :authenticate_api_user!
  def index
      alluser = User.all
      @users = []
      for user in alluser

          @role = user.roles.first.name
          user = JSON.parse(user.to_json)
          user["role"]= @role
          @users.push(user)
      end
      render json: @users
  end
end
