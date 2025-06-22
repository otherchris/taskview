import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="daily-interval"
export default class extends Controller {
  static targets = [ "interval", "timesPerDay" ]

  toggleInputs(event) {
    if (event.target.checked) {
      this.intervalTarget.classList.add("hidden")
      this.timesPerDayTarget.classList.remove("hidden")
    } else {
      this.intervalTarget.classList.remove("hidden")
      this.timesPerDayTarget.classList.add("hidden")
    }
  }
}
