document.addEventListener('turbo:load', function() {
  console.log("turbo:load event fired"); // turbo:loadイベントが発火したことを確認

  var urlParams = new URLSearchParams(window.location.search);
  console.log("URL parameters: ", urlParams.toString()); // URLパラメータが正しく取得できていることを確認

  var userSignedIn = document.body.dataset.userSignedIn === 'true';
  console.log("User signed in: ", userSignedIn); // ユーザーがサインインしていることを確認

  if (userSignedIn && urlParams.has('show_guide_modal')) {
    console.log("Showing guide modal"); // ガイドモーダルを表示する条件が満たされていることを確認

    var guideModal = document.getElementById('guideModal');
    var modalInstance = new bootstrap.Modal(guideModal);
    modalInstance.show();
  }
});