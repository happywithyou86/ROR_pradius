$(document).ready(function() {
  $("#recent-activity-section").on("click", ".like-activity", function() {
    $.ajax({
      type: "POST",
      url: "/activity_likes/create",
      data: {"class": $(this).attr("data-class"), "id": $(this).attr("data-id")},
      success: function(data) {
        $("a[data-id=" + data.id + "][data-class=" + data.class + "][class=like-activity]").html("Liked (" + data.likes + ")");
      }});
  }).on("click", ".comment-activity", function() {
      $(this).parent().find(".activity").toggle();
    });

  $(".new_activity_comment").on("click", ".btn-success", function() {
    var grandparent = $(this).parent().parent();

    var textarea = grandparent.find('textarea');

    $(this).parent('form').on('ajax:success',function(){
      textarea.val('');
    });

    grandparent.find('.comments').prepend('<div class="comment">' + textarea.val() + "<br>By <a href=''>You</a> just now</div>");
  });
});


