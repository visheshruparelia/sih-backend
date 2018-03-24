class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group
  def self.getDefaultincoming(groupId)
      @gUsers=GroupUser.where(group_id: id)
      for guser in @gUser
          if(user.defaultIncoming)
              return guser.user_id
          end
      end
      return nil
end
