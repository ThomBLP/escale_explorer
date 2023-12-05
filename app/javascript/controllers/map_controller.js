import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    markers: Array,
    monumentMarker: Object
  }

  connect() {
    mapboxgl.accessToken = 'pk.eyJ1IjoidnNjaG1pdHQiLCJhIjoiY2xwamdyd3RzMGI1dTJpcW9mMmp5MTZ4dCJ9.lrohzerGwUtMg0fiQmKs4Q';
    const monument = [this.monumentMarkerValue.lng, this.monumentMarkerValue.lat ];

    this.map = new mapboxgl.Map({
    container: this.element,
    style: 'mapbox://styles/mapbox/streets-v12',
    center: monument,
    zoom: 15
    });

    this.addMarkers()


  }

  addMarkers() {
    this.markersValue.forEach(marker => {
      new mapboxgl.Marker()
      .setLngLat([marker.lng, marker.lat])
      .setPopup(new mapboxgl.Popup().setHTML('<h3>' + marker.name + '</h3>'))
      .addTo(this.map);
    });
  }
}
