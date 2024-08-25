$(document).ready(function() {
  var urlParams = new URLSearchParams(window.location.search);
  if (urlParams.has('show_modal')) {
    $('#locationModal').modal('show');
  }
});