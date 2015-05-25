(function() {
  jQuery(function() {
    $('.wrapper').width($(window).width());
    if ($(window).width() < 1190) {
      return $('.wrapper').width(1190);
    }
  });

  $(window).resize(function() {
    $('.wrapper').width($(window).width());
    if ($(window).width() < 1190) {
      return $('.wrapper').width(1190);
    }
  });

}).call(this);
