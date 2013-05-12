class PostPolicy < ApplicationPolicy
  multiple_actions :new, :create, :edit, :update, :destroy do
    is_admin?
  end

  def show?
    true
  end
end

