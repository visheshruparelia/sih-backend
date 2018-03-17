class Allfile < ApplicationRecord
  require 'set'

  belongs_to :user, foreign_key: 'currentOwner_id'
  belongs_to :user, foreign_key: 'created_by_id'

  enum status: [ :legalhold, :lost, :etc]
  enum priority: [ :low, :medium, :high]

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
