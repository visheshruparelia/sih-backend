class User < ApplicationRecord
  rolify
  after_create :assign_default_role

  def assign_default_role
    self.add_role(:employee) if self.roles.blank?
  end
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User

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
