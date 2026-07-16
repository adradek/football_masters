module SquadsHelper
  def squad_html_class(squad_record)
    return "secondary-squad" unless squad_record.main?

    squad_record.user == current_user ? "is-current-user" : ""
  end

  # топ 1% — золото, топ 10% — зелёный, топ 50% — синий, дальше — серый
  def percentil_tier(percentil)
    case percentil
    when ..1 then "warning"
    when ..10 then "success"
    when ..50 then "info"
    else "secondary"
    end
  end

  # адаптивная точность: 0.02 / 1.3 / 45
  def format_percentil(percentil)
    if percentil < 0.01
      "< 0.01"
    elsif percentil < 0.1
      format("%.2f", percentil)
    elsif percentil < 10
      format("%.1f", percentil)
    else
      percentil.round.to_s
    end
  end

  def percentil_title(percentil)
    beaten =
      if percentil < 0.01
        "> 99.99"
      elsif percentil < 0.1
        format("%.2f", 100 - percentil)
      elsif percentil < 10
        format("%.1f", 100 - percentil)
      else
        (100 - percentil).round.to_s
      end

    total = number_with_delimiter(Statistics::TOTAL_SQUADS, delimiter: " ")
    "Лучше, чем #{beaten}% из #{total} сквадов сопоставимой стоимости"
  end
end
