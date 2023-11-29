// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails


import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

let url = `https://api.openweathermap.org/data/2.5/weather?q=Lyon&appid=${WEATHER_API_KEY}&units=metric&lang=fr`;
fetch(url).then( response => response.json()).then( data => {
  console.log(data => console.log(data)));

  document.querySelector("#weatherlogo").innerHTML = data.icon;
  document.querySelector("#temp").innerHTML = "<i class='fa-solid fa-temperature-three-quarters' style='#0432ff;'></i>" + data.main.temp + '°C';
  document.querySelector("#wind").innerHTML = "<i class='fa-solid fa-wind' style='#0432ff;'></i>" + data.wind.speed + 'km/h';
}
