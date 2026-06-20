module Admin
  class BonusPolicy < Admin::ApplicationPolicy
    # Начисление бонусов — действие уровня superadmin (наследуется из Admin::ApplicationPolicy#create?).
  end
end
