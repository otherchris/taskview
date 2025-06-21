import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "modal" ]

  open() {
    this.modalTarget.classList.remove("hidden")
    document.body.classList.add("modal-open")
    this.addBackdrop()
  }

  close() {
    this.modalTarget.classList.add("hidden")
    document.body.classList.remove("modal-open")
    this.removeBackdrop()
  }

  addBackdrop() {
    this.backdrop = document.createElement("div")
    this.backdrop.className = "modal-backdrop"
    this.backdrop.addEventListener("click", () => this.close())
    document.body.appendChild(this.backdrop)
  }

  removeBackdrop() {
    if (this.backdrop) {
      this.backdrop.remove()
    }
  }
} 