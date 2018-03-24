class User < ApplicationRecord
  rolify
  after_create :assign_default_role
  def self.checkAuthorityOver(user_id , request_id)
        @groups=[]
        @authority_over = []
        @authority=[]
           @groups=GroupUser.where(user_id: current_user.id)
           for group in @groups
             @groupgroups=GroupGroup.where(groupId_id: group.id)
             for groupgroup in @groupgroups
               @authority.push(groupgroup.authorityOver_id)
             end
           end
        for g in authority
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
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User
end
