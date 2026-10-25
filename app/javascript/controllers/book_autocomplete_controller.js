import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="book-autocomplete"
export default class extends Controller {
  submit() {
    this.element.requestSubmit()
  }

  touchStart(event) {
    event.target.closest("li[role='option']")?.classList.add("bg-blue-100")
  }

  touchEnd(event) {
    event.target.closest("li[role='option']")?.classList.remove("bg-blue-100")
  }
}
