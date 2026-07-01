module Admin
  class ApplicationPolicy < ::ApplicationPolicy
    def index?    = read_level
    def show?     = read_level
    def create?   = invasive_level
    def update?   = invasive_level
    def destroy?  = invasive_level

    private

    def read_level = admin?
    def invasive_level = superadmin?

    def admin?
      user.present? && user.admin_access?
    end

    def superadmin?
      user.present? && user.superadmin?
    end

    class Scope < ::ApplicationPolicy::Scope
      def resolve
        scope.all
      end
    end
  end
end
