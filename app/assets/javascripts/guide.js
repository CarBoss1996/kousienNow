import jQuery from 'jquery';
window.$ = window.jQuery = jQuery;

$(function() {
  if (sessionStorage.getItem("new_user") === "true") {
    $('#guideModal').modal('show');
  }
});

$('#guideModal').on('shown.bs.modal', function () {
  sessionStorage.removeItem("new_user"); // モーダルが表示された後はセッションストレージから削除
});