class AccountPolicy < ApplicationPolicy

  def create?
    # TODO: give manager the ability to create accounts for others
    record == user.account
  end

  def show?
    user.manager? || record == user.account
  end

  def update?
    user.manager? || record == user.account
  end
  
end
