class Api::UserController < ApplicationController
    load_and_authorize_resource
    before_action :authenticate_user!
  def index
      alluser = User.all
      @users = []
      for user in alluser
          @groupuser = GroupUser.where(user_id: user.id)
          @role = user.roles.first.name
          user = JSON.parse(user.to_json)
          for g in @groupuser
              group = Group.find(g.group_id)
              if group.isDepartment
                  user["department"] = group.name
              end
          end
          user["role"]= @role
          @users.push(user)
      end
      render json: @users
  end
end
