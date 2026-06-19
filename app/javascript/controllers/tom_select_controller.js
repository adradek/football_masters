import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

// Превращает обычный <select> в выпадающий список с поиском.
export default class extends Controller {
  connect() {
    this.select = new TomSelect(this.element, {
      maxOptions: null,
      placeholder: this.element.dataset.tomSelectPlaceholder,
      // Ищем без учёта регистра как по названию, так и по содержимому (флаг + имя).
      searchField: ["text"]
    })
  }

  disconnect() {
    this.select?.destroy()
  }
}
