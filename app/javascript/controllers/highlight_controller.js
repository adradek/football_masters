import { Controller } from "@hotwired/stimulus"

// Подсвечивает строки сборных в зависимости от отмеченных чек-боксов юзеров.
// Твой выбор красит строку синим, выбор соперника — красным,
// а пересечение (твоя нация и нация соперника совпадают) — фиолетовым.
export default class extends Controller {
  static targets = ["checkbox", "row"]
  static values = { currentUserId: Number }

  connect() {
    this.refresh()
  }

  refresh() {
    const checkedIds = new Set(
      this.checkboxTargets
        .filter((checkbox) => checkbox.checked)
        .map((checkbox) => Number(checkbox.dataset.userId))
    )

    const myId = this.currentUserIdValue

    this.rowTargets.forEach((row) => {
      const ownerIds = (row.dataset.ownerIds || "")
        .split(",")
        .filter(Boolean)
        .map(Number)

      const mine = checkedIds.has(myId) && ownerIds.includes(myId)
      const rival = ownerIds.some((id) => id !== myId && checkedIds.has(id))

      row.classList.toggle("hl-mine", mine && !rival)
      row.classList.toggle("hl-rival", rival && !mine)
      row.classList.toggle("hl-both", mine && rival)
    })
  }
}
