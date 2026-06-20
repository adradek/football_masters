module Admin
  class MatchPolicy < Admin::ApplicationPolicy
    def pending? = read_level

    # Редактировать можно только не доведённый до completed матч.
    def update? = superadmin? && editable_record?

    private

    def read_level = superadmin?

    def editable_record? = record.is_a?(Match) && !record.completed?
  end
end
