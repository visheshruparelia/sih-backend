class FileUser < ApplicationRecord
  belongs_to :user, foreign_key: 'userId_id'
  belongs_to :allfile, foreign_key: 'fileId_id'

  def self.getUsers(groupIds)
    @users=[]
    for id in groupIds
      @gUser=GroupUser.where(group_id: id)
      for user in @gUser
        @users.push(user.user_id)
      end
    end
    return @users.to_set
  end

end
