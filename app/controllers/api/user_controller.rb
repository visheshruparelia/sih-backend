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

  def show
    if(checkAuthorityOver(current_user.id , params[:id]))
        @groupuser = GroupUser.where(user_id: params[:id])
        @role = user.roles.first.name
        for g in @groupuser
            group = Group.find(g.group_id)
            if group.isDepartment
                user["department"] = group.name
            end
        end
        user["role"]= @role
        render User.find(params[:id])
    end
  end

  # MAKE USERS IN ADMIN PANEL

  def make
    @email=params[:email]
    @name=params[:name]
    @password=params[:password]
    @password_confirmation=params[:password_confirmation]
    a=User.new
    a.email=@email
    a.name=@name
    a.password=@password
    a.password_confirmation=@password_confirmation
    a.save

    render json: a, status: 201
  end
end
