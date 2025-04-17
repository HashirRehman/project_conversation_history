import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["readView", "editView"]

  toggleEdit() {
    this.readViewTarget.classList.add("hidden")
    this.editViewTarget.classList.remove("hidden")
  }

  cancelEdit() {
    this.readViewTarget.classList.remove("hidden")
    this.editViewTarget.classList.add("hidden")
  }
}
