import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="places"
export default class extends Controller {
  static targets = [ "list" ]
  connect() {
    ("connect");
    navigator.geolocation.getCurrentPosition((position) => {
      (position);
      const latitude  = position.coords.latitude;
      const longitude = position.coords.longitude;
      console.log(latitude);
      console.log(longitude);

      const url = new URL(window.location.href);
      url.searchParams.set('latitude', latitude);
      url.searchParams.set('longitude', longitude);

      ("latitude", latitude);
      ("longitude", longitude);

      fetch(url.href,
        {
          headers: {"Accept": "text/plain"},
        })
      .then(response => response.text())
      .then((data) => {
        ("data", data);
        console.log(data);
        this.listTarget.outerHTML = data
      })
    })

  }
}
