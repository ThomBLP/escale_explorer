import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "overlay" ]
  connect() {

  }

  open() {
    this.element.classList.add("active");
  }
  close(event) {
    event.stopPropagation();
    this.element.classList.remove("active");
  }
}
