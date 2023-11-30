import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="places"
export default class extends Controller {
  static targets = [ "list" ]
  connect() {
    console.log("connext");
    navigator.geolocation.getCurrentPosition((position) => {
      const latitude  = position.coords.latitude;
      const longitude = position.coords.longitude;

      const url = new URL(window.location.href);
      url.searchParams.set('latitude', latitude);
      url.searchParams.set('longitude', longitude);
      console.log(url.href);

      fetch(url.href,
        {
          headers: {"Accept": "text/plain"}
        })
      .then(response => response.text())
      .then((data) => {
        console.log("data", data);
        this.listTarget.outerHTML = data
      })
    })

  }
}
