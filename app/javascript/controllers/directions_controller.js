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
// __________________replace______________________________
        coordinates.forEach(coord => {
          new mapboxgl.Marker()
            .setLngLat(coord)
            .addTo(map);
        });
// __________________replace______________________________
        // coordinates.forEach(coord => {
        //   const popup = new mapboxgl.Popup({ offset: 25 })
        //     .setText(`Nom du lieu : ${@place.name}`); // Remplacez `coord.name` par la propriété qui contient le nom du lieu

        //   new mapboxgl.Marker()
        //     .setLngLat(coord)
        //     .setPopup(popup) // Associer le popup au marqueur
        //     .addTo(map);
        // });
// __________________replace______________________________
        const bounds = coordinates.reduce(function(bounds, coord) {
          return bounds.extend(coord);
        }, new mapboxgl.LngLatBounds(coordinates[0], coordinates[0]));

        map.fitBounds(bounds, { padding: 100 } );

        fetch(`https://api.mapbox.com/directions/v5/mapbox/${(travelMode)}/${coordinates.join(';')}?annotations=duration&overview=full&access_token=${mapboxgl.accessToken}&geometries=geojson`)
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

          // fetch(`https://api.mapbox.com/directions-matrix/v1/mapbox/${(travelMode)}/${coordinates.join(';')}?access_token=${mapboxgl.accessToken}`)
          // .then(response => response.json())
          // .then(data => {
          //   const durations = data.duration[0];
          //   };
      });
    } else {
      console.log("La géolocalisation n'est pas disponible sur ce navigateur");
    }
  }
}
