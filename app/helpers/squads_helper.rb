module SquadsHelper
  def squad_html_class(squad_record)
    return "secondary-squad" unless squad_record.main?

    squad_record.user == current_user ? "is-current-user" : ""
  end
end
