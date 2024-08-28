document.addEventListener('turbo:load', function() {

  var urlParams = new URLSearchParams(window.location.search);

  var userSignedIn = document.body.dataset.userSignedIn === 'true';

  if (userSignedIn && urlParams.has('show_guide_modal')) {

    var guideModal = document.getElementById('guideModal');
    var modalInstance = new bootstrap.Modal(guideModal);
    modalInstance.show();
  }
});