class RevisionPolicy < ApplicationPolicy

  multiple_actions :new, :create, :edit, :update do
    is_signed_in?
  end

  def destroy?
    is_admin? || (is_author? && !record.approved)
  end

  def approve?
    is_admin?
  end
end

