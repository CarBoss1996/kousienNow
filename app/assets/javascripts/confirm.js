document.addEventListener('click', (event) => {
  const element = event.target;
  if (element.hasAttribute('data-confirm')) {
    const message = element.getAttribute('data-confirm');
    if (!window.confirm(message)) {
      event.preventDefault();
    }
  }
});