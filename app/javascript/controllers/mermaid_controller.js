import { Controller } from "@hotwired/stimulus"
import mermaid from "mermaid"
// Connects to data-controller="mermaid"
export default class extends Controller {
  async connect() {
    mermaid.initialize({
      startOnLoad: false
    })

    await mermaid.run({
      nodes: [this.element]
    })
  }
}
