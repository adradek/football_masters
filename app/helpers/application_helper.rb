module ApplicationHelper
  DEFAULT_AVATAR_COLOR = "#dee2e6"

  def admin_access?
    user_signed_in? && current_user.admin_access?
  end

  def superadmin?
    user_signed_in? && current_user.superadmin?
  end

  # Цветной кружок с инициалами юзера — замена аватара.
  def user_avatar(user, size: "1.5rem")
    bg = user.color.presence || DEFAULT_AVATAR_COLOR
    tag.span(
      user.initials,
      class: "d-inline-flex align-items-center justify-content-center rounded-circle border fw-bold user-avatar",
      style: "width: #{size}; height: #{size}; background-color: #{bg}; " \
             "color: #{contrast_color(bg)}; font-size: calc(#{size} * 0.5);",
      title: user.name
    )
  end

  # Чёрный или белый текст в зависимости от яркости фона, чтобы инициалы читались.
  def contrast_color(hex)
    hex = hex.to_s.delete("#")
    return "#000" unless hex.length == 6

    r, g, b = hex.scan(/../).map { |c| c.to_i(16) }
    luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255
    luminance > 0.6 ? "#000" : "#fff"
  end
end
