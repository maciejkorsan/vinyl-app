import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  connect() {
    document.addEventListener("keydown", this.handleKeydown.bind(this))
    this.element.showModal()
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeydown.bind(this))
  }

  handleKeydown(event) {
    if (event.key === "Escape") {
      this.close()
    }
  }

  clickOutside(event) {
    if (event.target === this.element) {
      this.close()
    }
  }

  close() {
    this.element.close()
  }
}
