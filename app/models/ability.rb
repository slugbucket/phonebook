class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    user ||= User.new # guest user (not logged in)
    if user.roles.map(&:name)[0] == "admin"
      can [:edit, :update], Phone
      can [:edit, :update, :create, :destroy], Category
      can [:edit, :update, :create, :destroy], Department
      can [:create, :destroy], Extension
      can [:edit, :update, :create, :destroy], ExtensionRange
      can [:edit, :update, :create, :destroy], Role
      can [:edit, :update, :create, :destroy], Room
      can [:edit, :update, :create, :destroy], SubDepartment
      can [:edit, :update, :create, :destroy], User
    elsif user.roles.map(&:name)[0] == "editor"
      can [:edit, :update, :read], Phone
      cannot :manage, Category
      cannot :manage, Department
      cannot :manage, SubDepartment
      cannot :manage, ExtensionRange
      cannot :manage, Role
      cannot :manage, Room
      cannot :manage, User
    end
    can :read, :all 
  end
end
