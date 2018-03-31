class Api::GroupusersController < ApplicationController
  before_action :authenticate_user!
  wrap_parameters format: [:json]

  def index
    @groups=GroupUser.all
    render json: @groups, status: 200
  end

  def create
    @users=params[:users]
    @notAdded=[]
    @added=[]
    @dept=Group.find(params[:groupId]).isDepartment
    for user in @users
        @usergroup = GroupUser.new()
        @usergroup.group_id = params[:groupId]
        @usergroup.user_id = user
        @usergroup.defaultIncoming = params[:defaultIncoming]
        @usergroup.save
        @added.push(user)
    end
    render json: {"Added":@added, "NotAdded":@notAdded},status:200
    authorize! :create, @usergroup
  end

  def showgroups
    request_id=params[:id].to_i
      if User.checkAuthorityOver(current_user.id,request_id)
          @groups=GroupUser.where(user_id: request_id)
          @g=[]
          for group in @groups
              @temp=Group.find(group.group_id)
              if !@temp.isDepartment
                  @g.push(@temp)
              end
          end
          render json: @g, status: 200
      else
          render json: {"error":"Not allowed"}, status:403
      end
  end

  def show
    request_id=params[:id].to_i

    @rows=GroupUser.where(group_id: request_id)
    @users=[]
    @rows.each do |row|
      @users.push(row.user_id)
    end
    render json: @users

  end
end
