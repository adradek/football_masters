module NationsHelper
  # CSS-классы для флага: у выбывшей страны флаг обесцвечивается.
  def nation_flag_classes(nation, *base)
    base << "nation-leaved-flag" if nation.leaved?
    base.compact.join(" ")
  end

  # CSS-классы для названия: у выбывшей страны название чуть бледнее.
  def nation_name_classes(nation, *base)
    base << "nation-leaved-name" if nation.leaved?
    base.compact.join(" ")
  end
end
