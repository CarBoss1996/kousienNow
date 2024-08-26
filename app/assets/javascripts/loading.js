// Lottie player
import { DotLottieWC } from '@lottiefiles/dotlottie-wc';

customElements.define('lottie-player', DotLottieWC);

document.addEventListener('turbo:load', function() {
  // When the page has loaded, hide the animation
  var loadingAnimation = document.getElementById('loadingAnimation');
  loadingAnimation.style.display = 'none';
});