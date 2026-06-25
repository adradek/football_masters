module NationsHelper
  # Аватар сборной. Пока — кружок с флагом-эмодзи.
  # Когда подключим Active Storage (has_one_attached :avatar), здесь добавится ветка
  # с image_tag(nation.avatar) — вызывающий код менять не придётся.
  def nation_avatar(nation, size: "3rem")
    flag = tag.span(nation.flag_emoji, class: "nation-avatar-flag", style: "font-size: calc(#{size} * 0.62);")

    tag.span(
      flag,
      class: "d-inline-flex align-items-center justify-content-center rounded-circle border bg-light nation-avatar",
      style: "width: #{size}; height: #{size};",
      title: nation.name
    )
  end

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
