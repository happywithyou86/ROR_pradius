$(document).ready(function() {

  // Handles the plus and minus icons of the forum accordion
  $(".panel").on("click", ".glyphicon", function() {
    if ($(this).hasClass("glyphicon-minus") == true) {
      $(this).removeClass("glyphicon-minus").addClass("glyphicon-plus");

      $(".glyphicon:not(this)").removeClass("glyphicon-minus").addClass("glyphicon-plus");
    } else {
      $(".glyphicon:not(this)").removeClass("glyphicon-minus").addClass("glyphicon-plus");

      $(this).removeClass("glyphicon-plus").addClass("glyphicon-minus");
    }
  });
});
$( window ).load(function() {
  $( "#forum_text_area" ).focus();
});
