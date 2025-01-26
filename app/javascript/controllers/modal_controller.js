import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "close"]
  
  connect() {
    document.addEventListener("keydown", this.handleKeydown.bind(this))
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeydown.bind(this))
  }

  handleKeydown(event) {
    if (event.key === "Escape") {
      this.close()
    }
  }

  close() {
    this.modalTarget.close()
  }
}
