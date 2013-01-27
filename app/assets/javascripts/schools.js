$(document).ready(function() {
  $('body').on('hidden', '.modal', function () {
    $(this).removeData('modal');
  });
  
});