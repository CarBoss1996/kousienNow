document.addEventListener("DOMContentLoaded", () => {
  document.getElementById('get-location').addEventListener('click', () => {
    if ("geolocation" in navigator) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const latitude = position.coords.latitude;
          const longitude = position.coords.longitude;

          document.getElementById('latitude').value = latitude;
          document.getElementById('longitude').value = longitude;
          document.getElementById('location-info').innerText = `緯度: ${latitude}, 経度: ${longitude}`;

          const name = getNameFromApi(latitude, longitude);
          document.getElementById('name').value = name;
        },
        (error) => {
          alert("位置情報が利用できません。");
        },
        {
          enableHighAccuracy: true,
          maximumAge: 30000,
          timeout: 27000,
        }
      );
    } else {
      alert("このブラウザでは位置情報がサポートされていません。");
    }
  });
});

function getNameFromApi(latitude, longitude) {
  return latitude + longitude;
}