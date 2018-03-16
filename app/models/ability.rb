class Ability
  include CanCan::Ability
      def initialize(user)
        alias_action :create, :read, :update, :destroy, to: :crud
        if user.isAdmin?
          can :crud, Group
        end
  end
end
