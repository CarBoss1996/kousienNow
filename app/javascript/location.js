// ユーザーの位置情報をチェックする関数
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
  for (var i = 0; i < seats.length; i++) {
    if (isPointInPolygon(userLocation, seats[i].spots)) {
      alert(`今日は${seats[i].seat_name}から応援ですか？`);
      userInSeat = true;
      break;
    }
  }

  if (!userInSeat) {
    location_id = 9;
    alert("今日は自宅から応援ですか？");
  }
}

// seatsテーブルからデータを取得する関数
function getSeatsData(callback) {
  // APIを呼び出してデータを取得
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

window.onload = function() {
  document.getElementById("location-btn").onclick = function() {
    navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
  };

  // 取得に成功した場合の処理
  function successCallback(position){
    // 緯度を取得し画面に表示
    var latitude = position.coords.latitude;
    document.getElementById("latitude").innerHTML = latitude;
    // 経度を取得し画面に表示
    var longitude = position.coords.longitude;
    document.getElementById("longitude").innerHTML = longitude;

    // ユーザーの位置情報をチェック
    var userLocation = {
      lat: latitude,
      lng: longitude
    };

    // seatsテーブルからデータを取得
    getSeatsData(function(seats) {
      checkUserLocation(userLocation, seats);
    });
  };

  // 取得に失敗した場合の処理
  function errorCallback(error){
    alert("位置情報が取得できませんでした");
  };
}