(function() {
  var autoScrollButton_animationSpeed, createScrollButton;

  autoScrollButton_animationSpeed = 800;

  $(document).ready(function() {
    createScrollButton();
    $("#auto-scroll-button").hide();
    return $(window).scroll(function() {
      if ($(this).scrollTop() > 100) {
        return $("#auto-scroll-button").fadeIn();
      } else {
        return $("#auto-scroll-button").fadeOut();
      }
    });
  });

  createScrollButton = function() {
    $('body').append("<img id=\"auto-scroll-button\" src=\"/assets/auto-scroll-button.png\">");
    return $("#auto-scroll-button").mouseup(function() {
      return $('body,html').animate({
        scrollTop: 0
      }, autoScrollButton_animationSpeed);
    });
  };

}).call(this);
