import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// Connects to data-controller="redirect"
export default class extends Controller {
  static values = {
    url: String
  }

  connect() {
    Turbo.visit(this.urlValue)
  }
}
