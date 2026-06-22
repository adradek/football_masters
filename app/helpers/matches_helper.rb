module MatchesHelper
  def match_stage(match)
    return match.stage.humanize unless match.group_round?

    [match.home, match.away].compact.first&.group&.name
  end
end
