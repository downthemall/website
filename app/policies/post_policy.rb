class PostPolicy < ApplicationPolicy
  multiple_actions :new, :create, :edit, :update, :destroy do
    is_admin?
  end
end
