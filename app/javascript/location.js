window.onload = function() {
  document.getElementById("location-btn").onclick = function() {
    navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
  };

  function successCallback(position){
    var latitude = position.coords.latitude;
    var longitude = position.coords.longitude;
    document.getElementById("latitude").innerHTML = latitude;
    document.getElementById("longitude").innerHTML = longitude;

    var userLocation = {
      lat: latitude,
      lng: longitude
    };

    getSeatsData(function(seats) {
      seats.forEach(seat => {
        if (seat.spots) {
          seat.spots = JSON.parse(seat.spots); // spotsをJSONとしてパース
        }
      });
      checkUserLocation(userLocation, seats);
    });
  };

  function errorCallback(error){
    alert("位置情報が取得できませんでした");
  }
}

function getSeatsData(callback) {
  fetch('/api/seats')
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();
    })
    .then(data => callback(data))
    .catch(error => console.error('Error:', error));
}

function checkUserLocation(userLocation, seats) {
  function isPointInPolygon(point, polygon) {
    var x = point.lng, y = point.lat;

    var inside = false;
    for (var i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
      var xi = polygon[i].lng, yi = polygon[i].lat;
      var xj = polygon[j].lng, yj = polygon[j].lat;

      var intersect = ((yi > y) !== (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
      if (intersect) inside = !inside;
    }

    return inside;
  };

  var userInSeat = false;
  var seatName;
  for (var i = 0; i < seats.length; i++) {
    if (seats[i].spots && isPointInPolygon(userLocation, seats[i].spots)) {
      location_id = seats[i].id;
      seatName = seats[i].seat_name;
      userInSeat = true;
      break;
    }
  }

  if (!userInSeat) {
    location_id = 9; // デフォルトのlocation_idを設定
    for (var i = 0; i < seats.length; i++) {
      if (seats[i].id === location_id) {
        seatName = seats[i].seat_name;
        break;
      }
    }
  }

  document.getElementById('selected-seat').textContent = seatName;

  var seatSelectPopup = document.getElementById("seat-select-popup");
  var seatSelect = document.getElementById("seat-select");

  if (seatSelectPopup) {
    seatSelectPopup.style.display = "block";
    document.getElementById("seat-select").style.display = "block";
    document.getElementById("yes-btn").onclick = function() {
      updateSelectedSeat();
        document.getElementById("seat-select").style.display = "none";
        document.getElementById("seat-select-popup").style.display = "none";
      };
  } else {
    console.error('Error: "seat-select-popup" element is not found.');
  }
}

function updateSelectedSeat() {
  var selectBox = document.getElementById('location_id');
  var selectedSeat = selectBox.options[selectBox.selectedIndex].text;
  document.getElementById('selected-seat').textContent = selectedSeat;
  location_id = selectBox.value;
}
