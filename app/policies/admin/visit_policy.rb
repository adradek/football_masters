module Admin
  class VisitPolicy < Admin::ApplicationPolicy
    # Статистика посещений доступна только суперпользователю.
    def index? = superadmin?
  end
end
