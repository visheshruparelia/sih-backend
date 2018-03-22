class Api::GroupgroupController < ApplicationController
  before_action :authenticate_user!

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
end
