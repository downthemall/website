class Ability
  include CanCan::Ability

  def initialize(user)
    if user.blank?
      can :read, :all
      can [:new, :create], Comment
    elsif user.is_admin?
      can :manage, :all
    else
      can :read, :all
      can [:new, :create], Comment
      can [:edit, :update, :destroy], Comment, :user_id => user.id
    end
  end
end
