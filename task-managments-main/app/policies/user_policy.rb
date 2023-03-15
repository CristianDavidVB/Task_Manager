class UserPolicy < ApplicationPolicy
  def create?
    permissions.include? "create_user"
  end
end
