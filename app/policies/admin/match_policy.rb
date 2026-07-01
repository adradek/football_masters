module Admin
  class MatchPolicy < Admin::ApplicationPolicy
    def pending? = read_level

    private

    def read_level = admin?
    def invasive_level = admin?

    def editable_record? = record.is_a?(Match) && !record.completed?
  end
end
