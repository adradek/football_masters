module Admin
  class UserPolicy < Admin::ApplicationPolicy
    # Наследует правило «только админ» из Admin::ApplicationPolicy.
    # Переопределяй здесь, если для пользователей нужны особые правила.
  end
end
