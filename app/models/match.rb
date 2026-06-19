class Match < ApplicationRecord
  belongs_to :home, class_name: "Nation"
  belongs_to :away, class_name: "Nation"

  enum :stage, {
    group_round: 0,
    round_of_16: 1,
    eight_final: 2,
    quarter_final: 3,
    semi_final: 4,
    third_place: 5,
    final: 6
  }

  enum :state, { not_started: 0, live: 1, finished: 2, completed: 3 }
end
