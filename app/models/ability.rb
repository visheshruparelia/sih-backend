class Ability
  include CanCan::Ability
      def initialize(user)
        alias_action :create, :read, :update, :destroy, to: :crud
        if user.has_role? :superadmin
          can :crud, Group
          can :search, Group
          can :create, GroupUser
          can :make, User
        end
        if user.has_role? :admin
          can :read, Group
          can :search, Group
        end
        if user.has_role? :employee
          can :read, Group
          can :search, Group
        end
  end
end
