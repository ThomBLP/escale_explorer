import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meteo"
export default class extends Controller {

  static targets = ["icon", "temperature", "description"]
  connect() {
  let url = `https://api.openweathermap.org/data/2.5/weather?q=Lyon&appid=4d217d0a7ec86cd06c03f07f506b274b&units=metric&lang=fr`;
  fetch(url)
    .then( response => response.json())
    .then(data => {
      var iconurl = "http://openweathermap.org/img/w/" + (data.weather[0].icon) + ".png"
      this.iconTarget.src = iconurl;
      this.temperatureTarget.textContent = data.main.temp + '°C';
      var description = (data.weather[0].description);
      this.descriptionTarget.textContent = description;

    });
  }
}
