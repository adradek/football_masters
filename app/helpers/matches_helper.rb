module MatchesHelper
  def match_stage(match)
    return match.stage.humanize unless match.group_round?

    [match.home, match.away].compact.first&.group&.name
  end

  # Владельцы сборной — юзеры, у которых она в основном составе.
  def match_team_owners(nation)
    return [] unless nation

    nation.squads.select(&:main?).map(&:user).uniq
  end
end
