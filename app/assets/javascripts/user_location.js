document.addEventListener("DOMContentLoaded", function() {
  const icons = document.querySelectorAll('.seat-icon');
  icons.forEach(icon => {
    icon.addEventListener('click', function(event) {
      const tooltip = this.nextElementSibling;

      // アイコンの位置を取得
      const iconTop = parseFloat(icon.style.top);
      const iconLeft = parseFloat(icon.style.left);

      // ツールチップの位置を設定
      tooltip.style.top = (iconTop - 8) + '%';
      tooltip.style.left = (iconLeft + 1) + '%';

      tooltip.style.display = 'block';

      // アイコンに影を追加
      icon.style.boxShadow = '5px 5px 5px 0px rgba(0, 0, 0, 0.8)';
      event.stopPropagation();
    });
  });

  document.addEventListener('click', function(event) {
    const tooltips = document.querySelectorAll('.tooltip');
    tooltips.forEach(tooltip => {
      if (!tooltip.contains(event.target)) {
        tooltip.style.display = 'none';
      }
    });

// クリックされた場所がアイコン以外の場合、全てのアイコンの影を削除
    icons.forEach(icon => {
    icon.style.boxShadow = '';
    });
  });
});