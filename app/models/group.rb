class Group < ApplicationRecord
  def self.uniqueDepartment(user)
    connGroups=GroupUser.where(user_id: user)
    for group in connGroups
      @tempGroup=Group.find(group.group_id)
      if @tempGroup.isDepartment==true
        return false
      end
    end
    return true
  end
end
