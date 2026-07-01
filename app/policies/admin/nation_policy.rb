module Admin
  class NationPolicy < Admin::ApplicationPolicy
    private

    def read_level = admin?
    def invasive_level = admin?
  end
end
