import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

export default class extends Controller {
  static targets = ["modal"]

  connect() {
    this.modal = Modal.getOrCreateInstance(this.modalTarget)

    if (!this.wasShownInThisSession()) {
      this.modal.show()
      this.rememberAsShown()
    }
  }

  disconnect() {
    this.modal?.dispose()
  }

  open() {
    this.modal.show()
  }

  wasShownInThisSession() {
    try {
      return sessionStorage.getItem("champion-celebration-shown") === "true"
    } catch (_error) {
      return false
    }
  }

  rememberAsShown() {
    try {
      sessionStorage.setItem("champion-celebration-shown", "true")
    } catch (_error) {
      // The congratulation can still be shown when storage is unavailable.
    }
  }
}
