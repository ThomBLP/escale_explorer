import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "userPosition" ]

  connect() {
    if ("geolocation" in navigator) {
      navigator.geolocation.getCurrentPosition(function(position) {
        var userPositionElement = document.getElementById('user-position');
        userPositionElement.textContent = position.coords.latitude + ", "+ position.coords.longitude;
      });
    } else {
      console.log("La géolocalisation n'est pas disponible sur ce navigateur");
    }

    if ("geolocation" in navigator) {
      navigator.geolocation.getCurrentPosition((position) => {
        var latitude = position.coords.latitude;
        var longitude = position.coords.longitude;

        fetch(`https://api.mapbox.com/geocoding/v5/mapbox.places/${longitude},${latitude}.json?access_token=pk.eyJ1IjoidnNjaG1pdHQiLCJhIjoiY2xwamdyd3RzMGI1dTJpcW9mMmp5MTZ4dCJ9.lrohzerGwUtMg0fiQmKs4Q`)
          .then(response => response.json())
          .then(data => {
            var cityName = null;
            if (data.features.length > 0) {
              for (let i = 0; i < data.features[0].context.length; i++) {
                if (data.features[0].context[i].id.startsWith('place')) {
                  cityName = data.features[0].context[i].text;
                  break;
                }
              }
            }
            var cityElement = document.getElementById('geocity');
            if (cityElement) {
              cityElement.textContent = "Bienvenue à " + cityName;
            }
          });
      });
    } else {
      console.log("La géolocalisation n'est pas disponible sur ce navigateur");
    }
  }
}
