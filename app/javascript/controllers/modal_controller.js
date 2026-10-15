import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["dialog"]

  connect() {
    this.observer = new MutationObserver(() => {
      const frame = this.element.querySelector("turbo-frame#modal")

      if (frame && frame.innerHTML.trim() === "") {
        this.close()
      }
    })

    this.observer.observe(this.element, {
      childList: true,
      subtree: true
    })
  }

  disconnect() {
    this.observer.disconnect()
  }

  open() {
    if (!this.dialogTarget.open) {
      this.dialogTarget.showModal()
    }
  }

  close() {
    this.dialogTarget.close()
  }
}
