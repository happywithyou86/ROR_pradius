(function() {
  var userProfile;

  $(function() {
    return userProfile.init();
  });

  userProfile = {
    init: function() {
      return this.flagChangeListener();
    },
    flagChangeListener: function() {
      return $('.flags').on('click', '.flag', function(e) {
        var id;
        $('#profile-flag').attr('src', $(this).attr('src'));
        id = $(this).closest('a').data('country-id');
        return $('#country_id_field').val(id);
      });
    }
  };

}).call(this);
