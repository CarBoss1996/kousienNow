document.addEventListener('turbo:load', function() {
  var urlParams = new URLSearchParams(window.location.search);
  var userSignedIn = document.body.dataset.userSignedIn === 'true';
  if (userSignedIn && urlParams.has('show_modal')) {
    var locationModal = document.getElementById('locationModal');
    var modalInstance = new bootstrap.Modal(locationModal);
    modalInstance.show();
  }
});