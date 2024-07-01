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
      const allIcons = document.querySelectorAll('.seat-icon');
      allIcons.forEach(icon => {
        icon.style.width = '';
        icon.style.height = '';
        icon.dataset.enlarged = 'false'; // アイコンが拡大されていないことを示す
      });

      // // アイコンの位置を取得
      // const iconTop = parseFloat(icon.style.top);
      // const iconLeft = parseFloat(icon.style.left);

      // // ツールチップの位置を設定
      // tooltip.style.bottom = (iconTop + 20) + '%';
      // tooltip.style.left = (iconLeft - 5) + '%';

      // // アイコンが固定で中央に表示される場合
      // tooltip.style.bottom = '57%';
      // tooltip.style.left = '46%';

      tooltip.style.display = 'block';

      // アイコンがすでに拡大されていない場合のみ、アイコンのサイズを変更
      if (icon.dataset.enlarged === 'false') {
        let style = window.getComputedStyle(icon);
        let originalWidth = parseFloat(style.width);
        let originalHeight = parseFloat(style.height);

        icon.style.width = (originalWidth * 1.3) + 'px';
        icon.style.height = (originalHeight * 1.3) + 'px';
        icon.dataset.enlarged = 'true'; // アイコンが拡大されたことを示す
      }

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

    // クリックされた場所がアイコン以外の場合、全てのアイコンのサイズを元に戻す
    icons.forEach(icon => {
      icon.style.width = '';
      icon.style.height = '';
      icon.dataset.enlarged = 'false'; // アイコンが拡大されていないことを示す
    });
  });
});