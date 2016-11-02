class ServicePolicy < ApplicationPolicy
  def create?
    user.manager?
  end

  def update?
    user.manager?
  end
end
