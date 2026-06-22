class UserPolicy < ApplicationPolicy
  def update?
    superadmin? || record.id == user.id
  end

  private

  def read_level = true

  class Scope < ::ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
