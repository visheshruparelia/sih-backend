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
end
