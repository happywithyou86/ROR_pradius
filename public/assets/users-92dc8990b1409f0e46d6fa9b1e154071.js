function display_new_image(url) {
  $("#profile-picture").html('<img alt="Convert?fit=clip&amp;h=160&amp;w=160" src="' + url + '/convert?fit=clip&amp;h=160&amp;w=160">');
}

// Hide tabs and show selected tab when pill clicked on
$('#profile-tab a').click(function (e) {
  e.preventDefault();
  $(".tab-content > .tab-pane").hide();
  $(this).tab('show')
});

$(document).ready(function() {

  // Close modal when submit button is clicked
  $(".modal-body").on("click", "input[type='submit']", function() {
    $(".modal").modal('hide')
  });

});








