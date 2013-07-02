class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    else
      can [:read, :create], Node
      can :manage, Node, {:user_id => user.id}
    end
  end
end
