class Api::GroupgroupController < ApplicationController
  before_action :authenticate_user!
  require 'set'

  def create
    @curr_group=params[:group_id]
    @authOverGroups=params[:authorityOver]
    for authOverGroup in @authOverGroups
      if @curr_group!=authOverGroup
        a=GroupGroup.new
        a.authorityOver_id=authOverGroup
        a.groupId_id=@curr_group
        a.save
      end
    end
    render json: GroupGroup.all,status: 200
  end

  def authorityover
      @groups=[]
      @authority_over = []
      @authority=[]
         @groups=GroupUser.where(user_id: params[:id])
     for group in @groups
       @groupgroups=GroupGroup.where(groupId_id: group.id)
       for groupgroup in @groupgroups
         @authority.push(groupgroup.authorityOver_id)
       end
    end
    render json: @authority.to_set,status: 200
  end

end
