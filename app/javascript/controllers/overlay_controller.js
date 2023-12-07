import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "overlay", "cross", "bar" ]
  connect() {
    console.log(this.crossTarget);
  }

  open() {
    this.element.classList.add("active");
    this.crossTarget.classList.remove('d-none');
    this.barTarget.classList.add('d-none');
  }
  close(event) {
    event.stopPropagation();
    this.element.classList.remove("active");
    this.crossTarget.classList.add('d-none');
    this.barTarget.classList.remove('d-none');
  }
}
