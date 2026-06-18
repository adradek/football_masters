module Admin
  class SquadPolicy < Admin::ApplicationPolicy
    private

    def read_level
      superadmin?
    end
  end
end
