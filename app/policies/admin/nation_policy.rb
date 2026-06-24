module Admin
  class NationPolicy < Admin::ApplicationPolicy
    # Наследует правило «только админ» из Admin::ApplicationPolicy.
    # Переопределяй здесь, если для стран нужны особые правила.
  end
end
