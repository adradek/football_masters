module Admin
  class BonusPolicy < Admin::ApplicationPolicy
    private

    def read_level = admin?
    def invasive_level = admin?
  end
end
