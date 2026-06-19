module Admin
  class MatchPolicy < Admin::ApplicationPolicy
    def pending? = read_level

    private

    def read_level = superadmin?
  end
end
