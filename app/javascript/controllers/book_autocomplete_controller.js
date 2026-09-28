import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="book-autocomplete"
export default class extends Controller {
  submit() {
    this.element.requestSubmit()
  }
}
