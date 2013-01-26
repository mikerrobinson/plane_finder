$(document).ready(function() {
  $('.select-all').click(function(event) {
    $(event.target).closest('.filter-group').find('input[type="checkbox"]').attr('checked', true);
  });
  
  $('.select-none').click(function(event) {
    $(event.target).closest('.filter-group').find('input[type="checkbox"]').attr('checked', false);
  });
  
  $('body').on('hidden', '.modal', function () {
    $(this).removeData('modal');
  });
  
});
