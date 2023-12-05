import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="directions"
export default class extends Controller {
  static targets = [ "map" ]
  static values = {
    coordinates: Array,
    travelMode: String
  }

  connect() {
    if ("geolocation" in navigator) {
      navigator.geolocation.getCurrentPosition((position) => {
        var latitude  = position.coords.latitude;
        var longitude = position.coords.longitude;

        mapboxgl.accessToken = 'pk.eyJ1IjoidnNjaG1pdHQiLCJhIjoiY2xwamdyd3RzMGI1dTJpcW9mMmp5MTZ4dCJ9.lrohzerGwUtMg0fiQmKs4Q';
        const map = new mapboxgl.Map({
          container: this.mapTarget,
          style: 'mapbox://styles/mapbox/streets-v12',
          center: [longitude, latitude],
          zoom: 14
        });
        const travelMode = this.travelModeValue;
        const coordinates = this.coordinatesValue;
        coordinates.unshift([longitude, latitude]);

        coordinates.forEach(coord => {
          new mapboxgl.Marker()
            .setLngLat(coord)
            .addTo(map);
        });

        const bounds = coordinates.reduce(function(bounds, coord) {
          return bounds.extend(coord);
        }, new mapboxgl.LngLatBounds(coordinates[0], coordinates[0]));

        map.fitBounds(bounds, { padding: 50 });

        fetch(`https://api.mapbox.com/directions/v5/mapbox/${(travelMode)}/${coordinates.join(';')}?access_token=${mapboxgl.accessToken}&geometries=geojson`)
          .then(response => response.json())
          .then(data => {
            const route = data.routes[0];
            const time = route.duration;
            const geometry = route.geometry.coordinates;
            const geojson = {
              type: 'Feature',
              properties: {},
              geometry: {
                type: 'LineString',
                coordinates: geometry
              }
            };

            map.addLayer({
              id: 'route',
              type: 'line',
              source: {
                type: 'geojson',
                data: geojson
              },
              layout: {
                'line-join': 'round',
                'line-cap': 'round',
              },
              paint: {
                'line-color': '#3887be',
                'line-width': 5,
                'line-opacity': 0.75
              },
            });
          });
      });
    } else {
      console.log("La géolocalisation n'est pas disponible sur ce navigateur");
    }
  }
}
