class OrderPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.manager?
        scope.all
      else
        scope.where(account: user.account)
      end
    end
  end

  def index?
    user.manager? || record == user.account.try(:orders)
  end

  def create?
    user.manager? || record.try(:account) == user.account
  end

  def show?
    user.manager? || record.try(:account) == user.account
  end

  def update?
    user.manager? || record.try(:account) == user.account
  end

end
