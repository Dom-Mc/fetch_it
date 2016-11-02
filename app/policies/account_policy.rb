class AccountPolicy < ApplicationPolicy

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
    binding.pry
    user.manager? || record == user.account.try(:orders)
  end

  def create?
    binding.pry
    user.manager? || record.try(:account) == user.account
  end

  def show?
    binding.pry
    user.manager? || record.try(:account) == user.account
  end

  def update?
    binding.pry
    user.manager? || record.try(:account) == user.account
  end

end
