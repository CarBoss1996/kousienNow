// Lottie player
import { defineCustomElements } from '@dotlottie/player-component/loader';

defineCustomElements(window);

document.addEventListener('turbo:load', function() {
  // When the page has loaded, hide the animation
  var loadingAnimation = document.getElementById('loadingAnimation');
  loadingAnimation.style.display = 'none';
});