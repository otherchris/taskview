import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.parentNode.classList.remove('hidden')
  }

  close() {
    this.element.parentNode.classList.add('hidden')
    this.element.remove()
  }

  closeWithKeyboard(e) {
    if (e.key === "Escape") {
      this.close()
    }
  }

  hideBeforeRender(event) {
    if (this.element.querySelectorAll('[id=modal]').length > 1) {
      this.element.querySelector('[id=modal]').classList.add('hidden')
    }
  }
} 