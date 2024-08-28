document.addEventListener('turbo:load', function() {
  var userSignedIn = document.body.dataset.userSignedIn === 'true';
  var promptEmail = document.body.dataset.promptEmail === 'true';
  if (userSignedIn && promptEmail) {
    var emailPromptModal = document.getElementById('emailPromptModal');
    var modalInstance = new bootstrap.Modal(emailPromptModal);
    modalInstance.show();
  }
});