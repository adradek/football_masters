import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// При смене стадии подгружает зависимые поля сборки матча плей-офф через turbo-stream.
export default class extends Controller {
  static targets = ["stage", "fields"]
  static values = { optionsUrl: String }

  reload() {
    const url = new URL(this.optionsUrlValue, window.location.origin)
    url.searchParams.set("stage", this.stageTarget.value)

    fetch(url, { headers: { Accept: "text/vnd.turbo-stream.html" } })
      .then((response) => response.text())
      .then((html) => Turbo.renderStreamMessage(html))
  }
}
