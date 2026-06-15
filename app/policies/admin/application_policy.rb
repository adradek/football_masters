module Admin
  class ApplicationPolicy < ::ApplicationPolicy
    def index?    = admin?
    def show?     = admin?
    def create?   = superadmin?
    def update?   = superadmin?
    def destroy?  = superadmin?

    private

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
