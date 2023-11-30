import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="places"
export default class extends Controller {
  static targets = [ "list" ]
  connect() {
    navigator.geolocation.getCurrentPosition((position) => {
      const latitude  = position.coords.latitude;
      const longitude = position.coords.longitude;

      fetch(`/places?latitude=${latitude}&longitude=${longitude}`,
        {
          headers: {"Accept": "text/plain"}
        })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data
      })
    })

  }
}
