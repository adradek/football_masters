class NationSeeder
  NATIONS = [
    { name: "Мексика", price: 13, group: "A", fifa_place: 15, fifa_rank: 1681, flag_emoji: "🇲🇽" },
    { name: "Южная Корея", price: 9, group: "A", fifa_place: 25, fifa_rank: 1588, flag_emoji: "🇰🇷" },
    { name: "Чехия", price: 5, group: "A", fifa_place: 41, fifa_rank: 1501, flag_emoji: "🇨🇿" },
    { name: "ЮАР", price: 1, group: "A", fifa_place: 60, fifa_rank: 1429, flag_emoji: "🇿🇦" },

    { name: "Швейцария", price: 11, group: "B", fifa_place: 19, fifa_rank: 1649, flag_emoji: "🇨🇭" },
    { name: "Канада", price: 7, group: "B", fifa_place: 30, fifa_rank: 1556, flag_emoji: "🇨🇦" },
    { name: "Катар", price: 1, group: "B", fifa_place: 55, fifa_rank: 1454, flag_emoji: "🇶🇦" },
    { name: "Босния и Герцеговина", price: 6, group: "B", fifa_place: 65, fifa_rank: 1385, flag_emoji: "🇧🇦" },

    { name: "Бразилия", price: 17, group: "C", fifa_place: 6, fifa_rank: 1761, flag_emoji: "🇧🇷" },
    { name: "Марокко", price: 11, group: "C", fifa_place: 8, fifa_rank: 1755, flag_emoji: "🇲🇦" },
    { name: "Шотландия", price: 5, group: "C", fifa_place: 43, fifa_rank: 1498, flag_emoji: "🏴󠁧󠁢󠁳󠁣󠁴󠁿" },
    { name: "Гаити", price: 0, group: "C", fifa_place: 83, fifa_rank: 1291, flag_emoji: "🇭🇹" },

    { name: "США", price: 11, group: "D", fifa_place: 16, fifa_rank: 1673, flag_emoji: "🇺🇸" },
    { name: "Турция", price: 12, group: "D", fifa_place: 22, fifa_rank: 1599, flag_emoji: "🇹🇷" },
    { name: "Австралия", price: 3, group: "D", fifa_place: 27, fifa_rank: 1580, flag_emoji: "🇦🇺" },
    { name: "Парагвай", price: 3, group: "D", fifa_place: 40, fifa_rank: 1503, flag_emoji: "🇵🇾" },

    { name: "Германия", price: 16, group: "E", fifa_place: 10, fifa_rank: 1730, flag_emoji: "🇩🇪" },
    { name: "Эквадор", price: 9, group: "E", fifa_place: 23, fifa_rank: 1594, flag_emoji: "🇪🇨" },
    { name: "Кот-д’Ивуар", price: 5, group: "E", fifa_place: 34, fifa_rank: 1532, flag_emoji: "🇨🇮" },
    { name: "Кюрасао", price: 0, group: "E", fifa_place: 82, fifa_rank: 1294, flag_emoji: "🇨🇼" },

    { name: "Нидерланды", price: 15, group: "F", fifa_place: 7, fifa_rank: 1757, flag_emoji: "🇳🇱" },
    { name: "Япония", price: 11, group: "F", fifa_place: 18, fifa_rank: 1660, flag_emoji: "🇯🇵" },
    { name: "Швеция", price: 4, group: "F", fifa_place: 38, fifa_rank: 1514, flag_emoji: "🇸🇪" },
    { name: "Тунис", price: 2, group: "F", fifa_place: 44, fifa_rank: 1483, flag_emoji: "🇹🇳" },

    { name: "Бельгия", price: 14, group: "G", fifa_place: 9, fifa_rank: 1734, flag_emoji: "🇧🇪" },
    { name: "Иран", price: 4, group: "G", fifa_place: 21, fifa_rank: 1615, flag_emoji: "🇮🇷" },
    { name: "Египет", price: 7, group: "G", fifa_place: 29, fifa_rank: 1563, flag_emoji: "🇪🇬" },
    { name: "Новая Зеландия", price: 1, group: "G", fifa_place: 85, fifa_rank: 1281, flag_emoji: "🇳🇿" },

    { name: "Испания", price: 23, group: "H", fifa_place: 2, fifa_rank: 1876, flag_emoji: "🇪🇸" },
    { name: "Уругвай", price: 12, group: "H", fifa_place: 17, fifa_rank: 1673, flag_emoji: "🇺🇾" },
    { name: "Кабо-Верде", price: 1, group: "H", fifa_place: 69, fifa_rank: 1366, flag_emoji: "🇨🇻" },
    { name: "Саудовская Аравия", price: 3, group: "H", fifa_place: 61, fifa_rank: 1421, flag_emoji: "🇸🇦" },

    { name: "Франция", price: 22, group: "I", fifa_place: 1, fifa_rank: 1877, flag_emoji: "🇫🇷" },
    { name: "Сенегал", price: 6, group: "I", fifa_place: 14, fifa_rank: 1688, flag_emoji: "🇸🇳" },
    { name: "Норвегия", price: 9, group: "I", fifa_place: 31, fifa_rank: 1550, flag_emoji: "🇳🇴" },
    { name: "Ирак", price: 1, group: "I", fifa_place: 57, fifa_rank: 1447, flag_emoji: "🇮🇶" },

    { name: "Аргентина", price: 17, group: "J", fifa_place: 3, fifa_rank: 1874, flag_emoji: "🇦🇷" },
    { name: "Австрия", price: 5, group: "J", fifa_place: 24, fifa_rank: 1593, flag_emoji: "🇦🇹" },
    { name: "Алжир", price: 8, group: "J", fifa_place: 28, fifa_rank: 1564, flag_emoji: "🇩🇿" },
    { name: "Иордания", price: 0, group: "J", fifa_place: 63, fifa_rank: 1391, flag_emoji: "🇯🇴" },

    { name: "Португалия", price: 18, group: "K", fifa_place: 5, fifa_rank: 1763, flag_emoji: "🇵🇹" },
    { name: "Колумбия", price: 10, group: "K", fifa_place: 13, fifa_rank: 1693, flag_emoji: "🇨🇴" },
    { name: "ДР Конго", price: 2, group: "K", fifa_place: 46, fifa_rank: 1478, flag_emoji: "🇨🇩" },
    { name: "Узбекистан", price: 2, group: "K", fifa_place: 50, fifa_rank: 1465, flag_emoji: "🇺🇿" },

    { name: "Англия", price: 19, group: "L", fifa_place: 4, fifa_rank: 1825, flag_emoji: "🏴󠁧󠁢󠁥󠁮󠁧󠁿" },
    { name: "Хорватия", price: 11, group: "L", fifa_place: 11, fifa_rank: 1717, flag_emoji: "🇭🇷" },
    { name: "Панама", price: 3, group: "L", fifa_place: 33, fifa_rank: 1540, flag_emoji: "🇵🇦" },
    { name: "Гана", price: 3, group: "L", fifa_place: 74, fifa_rank: 1346, flag_emoji: "🇬🇭" }
  ].freeze

  def call(with_groups: false)
    group_candidate = nil

    NATIONS.each do |nation_data|
      nation = find_or_create_nation(nation_data)

      if with_groups
        group_candidate = generate_group_and_bind_nation(letter: nation_data[:group], nation:, group_candidate:)
      end
    end
  end

  private

  def find_or_create_nation(nation_data)
    params = nation_data.slice(:fifa_place, :fifa_rank, :flag_emoji, :price)

    if (nation = Nation.find_by(name: nation_data[:name]))
      nation.update!(params)
      nation
    else
      Nation.create!(params.merge(name: nation_data[:name]))
    end
  end

  def generate_group_and_bind_nation(letter:, nation:, group_candidate:)
    group =
      if group_candidate && group_candidate.name == "Группа #{letter}"
        group_candidate
      else
        Group.find_or_create_by(name: "Группа #{letter}", order: letter.ord - "A".ord)
      end

    group.tap { it.nations << nation unless it.nations.map(&:name).include?(nation.name) }
  end
end
