import { isInsideKoshien } from './map.js';

let map;
let geocoder;
let marker;

function initMap() {
  geocoder = new google.maps.Geocoder();

  map = new google.maps.Map(document.getElementById('map'), {
    center: { lat: 34 + 43 / 60 + 16.407 / 3600, lng: 135 + 21 / 60 + 41.965 / 3600 },
    zoom: 18,
  });

  marker = new google.maps.Marker({
    position: { lat: 34 + 43 / 60 + 16.407 / 3600, lng: 135 + 21 / 60 + 41.965 / 3600 },
    map: map,
  });

  if ('geolocation' in navigator) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        const latitude = position.coords.latitude;
        const longitude = position.coords.longitude;

        document.getElementById('latitude').value = latitude;
        document.getElementById('longitude').value = longitude;

        if (isInsideKoshien(latitude, longitude)) {
          // Update the map and marker with the current position
          map.setCenter({ lat: latitude, lng: longitude });
          marker.setPosition({ lat: latitude, lng: longitude });
        } else {
          console.log("自宅から応援");
        }
      },
      (error) => {
        alert('位置情報が利用できません。');
      },
      {
        enableHighAccuracy: true,
        maximumAge: 30000,
        timeout: 27000,
      }
    );
  } else {
    alert('このブラウザでは位置情報がサポートされていません。');
  }
}
