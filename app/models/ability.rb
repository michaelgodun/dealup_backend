# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    elsif user.persisted?
      can :manage, Deal, user_id: user.id
      can :manage, Comment, user_id: user.id
      can :update, User, id: user.id
      can :read, Deal
      can :read, Comment
      can :create, Vote
    else
      can :read, Deal
      can :read, Comment
      can :read, User
    end
  end
end
