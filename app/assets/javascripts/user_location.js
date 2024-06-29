document.addEventListener("DOMContentLoaded", function() {
  const icons = document.querySelectorAll('.seat-icon');
  icons.forEach(icon => {
    icon.addEventListener('click', function(event) {
      const tooltip = this.nextElementSibling;

      // すべてのツールチップを非表示にする
      const allTooltips = document.querySelectorAll('.tooltip');
      allTooltips.forEach(tooltip => {
        tooltip.style.display = 'none';
      });
      const allIcons = document.querySelectorAll('.icon');
      allIcons.forEach(icon => {
        icon.style.width = '';
        icon.style.height = '';
      });

      // アイコンの位置を取得
      const iconTop = parseFloat(icon.style.top);
      const iconLeft = parseFloat(icon.style.left);

      // ツールチップの位置を設定
      tooltip.style.top = (iconTop - 5) + '%';
      tooltip.style.left = (iconLeft - 1) + '%';

      tooltip.style.display = 'block';

      // アイコンのサイズを変更
      let style = window.getComputedStyle(icon);
      let originalWidth = parseFloat(style.width);
      let originalHeight = parseFloat(style.height);

      icon.style.width = (originalWidth * 1.2) + 'px';
      icon.style.height = (originalHeight * 1.2) + 'px';
      event.stopPropagation();
    }, { once: true });
  });

  document.addEventListener('click', function(event) {
    const tooltips = document.querySelectorAll('.tooltip');
    tooltips.forEach(tooltip => {
      if (!tooltip.contains(event.target)) {
        tooltip.style.display = 'none';
      }
    });

    // クリックされた場所がアイコン以外の場合、全てのアイコンのサイズを元に戻す
    icons.forEach(icon => {
      icon.style.width = '';
      icon.style.height = '';
    });
  });
});