import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="characterselect"
export default class extends Controller {
  static targets = ["source", "target"]
  connect() {
    this.updateOptions()
  }

  updateOptions() {
    const sourceId = this.sourceTarget.value
    const targetId = this.targetTarget.value

    // 本人で選択した人物を相手側で選択不可にする
    this.targetTarget.querySelectorAll("option").forEach((option) => {
      option.disabled = sourceId !== "" && option.value === sourceId
    })

    // 相手で選択した人物を本人側で選択不可にする
    this.sourceTarget.querySelectorAll("option").forEach((option) => {
      option.disabled = targetId !== "" && option.value === targetId
    })
  }
}
