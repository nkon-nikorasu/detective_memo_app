import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "label"]

  toggle() {
    const isHidden = this.contentTarget.classList.toggle("hidden")

    this.labelTarget.textContent = isHidden ? "登録" : "閉じる"
  }
}