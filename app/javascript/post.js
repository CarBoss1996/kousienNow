document.addEventListener('DOMContentLoaded', (event) => {
  const textArea = document.getElementById('post_body');
  const maxLength = 255;
  const messageElement = document.createElement('p');
  textArea.parentNode.insertBefore(messageElement, textArea.nextSibling);

  textArea.addEventListener('input', (event) => {
    const currentLength = textArea.value.length;

    if (currentLength > maxLength) {
      messageElement.textContent = `${currentLength - maxLength} 文字オーバーです`;
      messageElement.style.color = 'red';
    } else {
      messageElement.textContent = `あと ${maxLength - currentLength} 文字入力できます`;
      messageElement.style.color = 'black';
    }
  });
});