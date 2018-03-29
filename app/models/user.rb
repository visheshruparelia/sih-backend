class User < ApplicationRecord
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable,:omniauthable
  include DeviseTokenAuth::Concerns::User
  rolify
  after_create :assign_default_role
  def self.checkAuthorityOver(user_id , request_id)
      if user_id==request_id
        return true
      end
      @groups=[]
      @authority_over = []
      @authority=[]
         @groups=GroupUser.where(user_id: user_id)
         for group in @groups
           @groupgroups=GroupGroup.where(groupId_id: group.id)
           for groupgroup in @groupgroups
             @authority.push(groupgroup.authorityOver_id)
           end
         end

      for g in @authority
          @authority_over = GroupUser.where(group_id: g.id)
          for users in @authority_over
              if(request_id == users.id)
                  return true
              end
          end
      end
      return false
  end

  def assign_default_role
      self.add_role(:employee) if self.roles.blank?
  end
  # Include default devise modules

  def self.checkAuthority(groupId,userId)
    if GroupUser.exists?(user_id: userId, group_id: groupId)
      return true
    else
      @groups=GroupUser.where(user_id: userId)
      for group in @groups
        @groupgroups=GroupGroup.where(groupId_id: group.id)
        for groupgroup in @groupgroups
          if group_id==groupgroup.authorityOver_id
            return true
        end
      end
      return false
    end
  end
  end
end
