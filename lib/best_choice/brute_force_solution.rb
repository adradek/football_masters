class BruteForceSolution
  DATA = [
    [ "Мексика", 13, 14 ],
    [ "Южная Корея", 9, 3 ],
    [ "Чехия", 5, 1 ],
    [ "ЮАР", 1, 5 ],
    [ "Швейцария", 11, 16 ],
    [ "Канада", 7, 9 ],
    [ "Катар", 1, 1 ],
    [ "Босния", 6, 5 ],
    [ "Бразилия", 17, 12 ],
    [ "Марокко", 11, 15 ],
    [ "Шотландия", 5, 3 ],
    [ "Гаити", 0, 0 ],
    [ "США", 11, 11 ],
    [ "Турция", 12, 3 ],
    [ "Австралия", 3, 6 ],
    [ "Парагвай", 3, 7 ],
    [ "Германия", 16, 8 ],
    [ "Эквадор", 9, 5 ],
    [ "Кот-д’Ивуар", 5, 7 ],
    [ "Кюрасао", 0, 1 ],
    [ "Нидерланды", 15, 9 ],
    [ "Япония", 11, 6 ],
    [ "Швеция", 4, 5 ],
    [ "Тунис", 2, 0 ],
    [ "Бельгия", 14, 14 ],
    [ "Иран", 4, 3 ],
    [ "Египет", 7, 8 ],
    [ "Новая Зеландия", 1, 1 ],
    [ "Испания", 23, 29 ],
    [ "Уругвай", 12, 2 ],
    [ "Кабо-Верде", 1, 5 ],
    [ "Саудовская Аравия", 3, 2 ],
    [ "Франция", 22, 25 ],
    [ "Сенегал", 6, 5 ],
    [ "Норвегия", 9, 17 ],
    [ "Ирак", 1, 0 ],
    [ "Аргентина", 17, 29 ],
    [ "Австрия", 5, 5 ],
    [ "Алжир", 8, 5 ],
    [ "Иордания", 0, 0 ],
    [ "Португалия", 18, 10 ],
    [ "Колумбия", 10, 13 ],
    [ "ДР Конго", 2, 5 ],
    [ "Узбекистан", 2, 0 ],
    [ "Англия", 19, 22 ],
    [ "Хорватия", 11, 7 ],
    [ "Панама", 3, 0 ],
    [ "Гана", 3, 5 ]
  ]
    .sort_by! { it[1] }
    .freeze

  MAX_COST = 65
  MAX_INDEX = DATA.size - 1

  attr_accessor :best_result, :best_choice, :choice, :meta_pointer

  def initialize
    @best_result = 0
    @best_choice = nil
    @choice = [ 0, 1, 2, 3, 4, 5, 6, 7 ]
    @meta_pointer = 7

    @super_squads = []
    @statistics = Hash.new(0)
  end

  def search_best_squad
    start = Time.now
    cnt = 0
    mln_cnt = 0

    begin
      check_squad

      cnt += 1
      if cnt >= 1_000_000
        mln_cnt += 1
        cnt = 0
        puts "#{mln_cnt}: #{Time.now - start}  -  #{best_result}"
      end
    end while move_squad?

    # require "pry-byebug"; binding.pry

    puts "\n\n--------------------------------"
    puts "Total time: #{Time.now - start}"
    puts "Result: #{best_result}"
    puts "Choice: #{get_participants(best_choice)}"

    puts "\n\n\n\n"
    puts "Super squads: #{@super_squads.map(&:inspect).join("\n")}"
    puts "\n\n\n"
    puts "Statistics: #{@statistics.inspect}"
  end

  def current_participants = get_participants(choice)

  private

  def data = DATA
  def get_participants(ch) = ch.map { |i| data[i] }
  def total_cost = current_participants.sum { it[1] }
  def total_value = current_participants.sum { it[2] }

  def check_squad
    if total_cost <= MAX_COST
      tv = total_value

      @super_squads << choice.dup if tv >= 109
      @statistics[tv] += 1 if total_cost >= 60

      if best_result < tv
        self.best_choice = choice.dup
        self.best_result = tv
      end
    end
  end

  def move_squad?
    moved = false

    begin
      if can_move_current_nation?
        pointer_nation_index = (choice[meta_pointer] += 1)

        while meta_pointer < choice.size - 1
          self.meta_pointer += 1
          pointer_nation_index += 1
          choice[meta_pointer] = pointer_nation_index
        end

        moved = true
      else
        return false if meta_pointer <= 0
        self.meta_pointer -= 1
      end
    end until moved

    true
  end

  def can_move_current_nation?
    meta_pointer < 7 ? choice[meta_pointer] + 1 < choice[meta_pointer + 1]
                     : choice[meta_pointer] < MAX_INDEX
  end
end

puts BruteForceSolution.new.search_best_squad
