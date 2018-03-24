class Api::GroupusersController < ApplicationController
  before_action :authenticate_user!
  wrap_parameters format: [:json]

  def create
    @users=params[:users]
    @notAdded=[]
    @added=[]
    @dept=Group.find(params[:groupId]).isDepartment
    for user in @users
      if (Group.uniqueDepartment(user) and @dept) or (!@dept)
        @usergroup = GroupUser.new()
        @usergroup.group_id = params[:groupId]
        @usergroup.user_id = user
        @usergroup.defaultIncoming = params[:defaultIncoming]
        @usergroup.save
        @added.push(user)
      else
        @notAdded.push(user)
      end
    end
    render json: {"Added":@added, "NotAdded":@notAdded},status:200
    authorize! :create, @usergroup
  end


  def show
    if checkAuthority(params[:id],current_user.id)
      @rows=GroupUser.where(group_id: params[:id])
      @users=[]
      for row in @rows
        @users.push(row.user_id)
      end
    else
      render json: {"error":"Not allowed"}, status:403
    end
  end
end
