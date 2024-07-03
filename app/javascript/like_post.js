window.showAndHideMessage = function(postId) {
  var heartIconElement = document.getElementById('like-button-for-post-' + postId);
  heartIconElement.classList.add('sparkle');

  setTimeout(function() {
    heartIconElement.classList.remove('sparkle');
  }, 500);
}