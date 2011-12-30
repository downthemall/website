class Ability
  include CanCan::Ability

  def initialize(user, session_token)
    if user.blank?
      can :read, :all
      can [:new, :create], Comment
      can [:edit, :update, :destroy], Comment do |comment|
        comment.user.blank? && comment.session_id == session_token
      end
    elsif user.is_admin?
      can :manage, :all
    else
      can :read, :all
      can [:new, :create], Comment
      can [:edit, :update, :destroy], Comment, :user_id => user.id
    end
  end
end
