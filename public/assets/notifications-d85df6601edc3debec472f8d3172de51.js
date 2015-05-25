(function() {
  var notificationsController;

  $(function() {
    return notificationsController.init();
  });

  notificationsController = {
    init: function() {
      this.longpull();
      return this.notificationListeners();
    },
    longpull: function() {
      var pull, self;
      self = this;
      pull = function() {
        return $.ajax({
          method: 'get',
          url: '/users/notifications/long_pull',
          success: self.updateBadge
        });
      };
      return setInterval(pull, 15000);
    },
    updateBadge: function(data) {
      if (data.request_number > 0) {
        $('#request_badge').text(data.request_number);
        $('#request_badge').show();
        $('.requests').data('need-update', 'true');
      }
      if (data.message_number > 0) {
        $('#message_badge').text(data.message_number);
        $('#message_badge').show();
        return $('.messages').data('need-update', 'true');
      }
    },
    notificationListeners: function() {
      var self;
      self = this;
      return $('.notify_icon').on('click', function(e) {
        $(this).find('.notification_badge').hide();
        if ($(this).data('not-type') === 'friend') {
          if ($('.requests').data('need-update') === 'true') {
            self.updateDropdownContent('requests');
          }
        }
        if ($(this).data('not-type') === 'message') {
          if ($('.messages').data('need-update') === 'true') {
            self.updateDropdownContent('messages');
          }
        }
        return self.setNotificationsRead($(this).data('not-type'));
      });
    },
    updateDropdownContent: function(type) {
      var self;
      self = this;
      return $.ajax({
        method: 'get',
        url: '/users/notifications/update_notifications',
        data: {
          type: type
        }
      }).done(function(response) {
        return self.updateToView(response, type);
      });
    },
    updateToView: function(responseBody, div) {
      $('.' + div).html(responseBody);
      return $('.' + div).data('need-update', 'false');
    },
    setNotificationsRead: function(type) {
      return $.ajax({
        method: 'patch',
        url: '/users/notifications/mark_read',
        data: {
          notify_type: type
        }
      });
    }
  };

}).call(this);
