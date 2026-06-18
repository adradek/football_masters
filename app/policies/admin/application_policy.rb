module Admin
  class ApplicationPolicy < ::ApplicationPolicy
    def index?    = read_level
    def show?     = read_level
    def create?   = superadmin?
    def update?   = superadmin?
    def destroy?  = superadmin?

    private

    def read_level
      admin?
    end

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
