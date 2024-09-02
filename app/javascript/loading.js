document.addEventListener('turbo:load', function() {
  var loading = document.getElementById('loading');
  var loadingBox = document.getElementById('loading_box');

  setTimeout(function() {
    fadeOut(loading);
  }, 1500); // ローディング画面を1.5秒（1500ms）待機してからフェードアウト

  setTimeout(function() {
    fadeOut(loadingBox);
  }, 1200); // ローディングテキストを1.2秒（1200ms）待機してからフェードアウト
});

function fadeOut(element) {
  var op = 1;  // initial opacity
  var timer = setInterval(function () {
      if (op <= 0.1){
          clearInterval(timer);
          element.style.display = 'none';
      }
      element.style.opacity = op;
      element.style.filter = 'alpha(opacity=' + op * 100 + ")";
      op -= op * 0.1;
  }, 50);
}