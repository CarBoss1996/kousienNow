document.addEventListener('turbo:load', function() {
  var urlParams = new URLSearchParams(window.location.search);
  var userSignedIn = document.body.dataset.userSignedIn === 'true';
  if (userSignedIn && urlParams.has('post')) {
    var locationModal = document.getElementById('postModal');
    var modalInstance = new bootstrap.Modal(postModal);
    modalInstance.show();
  }
});