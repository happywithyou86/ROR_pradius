(function() {
  var inviteFriends;

  $(function() {
    return inviteFriends.init();
  });

  inviteFriends = {
    init: function() {
      return this.formListener();
    },
    formListener: function() {
      var self;
      self = this;
      return $('#invite_friends_form').bind('ajax:success', function(evt, data, status, xhr) {
        document.getElementById("invite_friends_form").reset();
        return self.success(data);
      });
    },
    success: function(response) {
      $('.invitation_sent').show();
      return setTimeout(function() {
        return $('.invitation_sent').fadeOut();
      }, 3000);
    }
  };

}).call(this);
