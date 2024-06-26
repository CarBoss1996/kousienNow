document.addEventListener("DOMContentLoaded", function() {
  const icons = document.querySelectorAll('.seat-icon');
  const image = document.getElementById('stadium-image');
  icons.forEach(icon => {
    icon.addEventListener('click', function(event) {
      const tooltip = this.nextElementSibling;
      tooltip.style.display = 'block';
      // 画像の現在の大きさに対するパーセンテージを計算
      const x = event.clientX / image.offsetWidth * 100;
      const y = event.clientY / image.offsetHeight * 100;
      tooltip.style.left = `${x}%`;
      tooltip.style.top = `${y}%`;
    });
  });
  document.addEventListener('click', function(event) {
    const tooltips = document.querySelectorAll('.tooltip');
    tooltips.forEach(tooltip => {
      if (!tooltip.contains(event.target)) {
        tooltip.style.display = 'none';
      }
    });
  });
});