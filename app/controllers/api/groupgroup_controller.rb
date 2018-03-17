class Api::GroupgroupController < ApplicationController
  def defineAuthority
    @curr_group=params[:group_id]
    @authOverGroups=params[:authorityOver]
    for authOverGroup in @authOverGroups
      a=GroupGroup.new
      a.authorityOver_id=authOverGroup
      a.groupId_id=@curr_group
      a.save
    end
    render json: GroupGroup.all,status: 200
  end
end
