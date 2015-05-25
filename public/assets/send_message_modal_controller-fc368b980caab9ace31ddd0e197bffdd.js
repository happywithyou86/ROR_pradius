(function() {
  var sendMessageModalController;

  $(function() {
    return sendMessageModalController.init();
  });

  sendMessageModalController = {
    init: function() {
      this.modalClickListener();
      this.sendMessageFormListener();
      this.hideModalListener();
      return this.sendMessageToUserWithName();
    },
    modalClickListener: function() {
      var self;
      self = this;
      return $('.message_modal_autocomplete').on('click', function(e) {
        e.preventDefault();
        return self.queryServerForAutocompleteNames();
      });
    },
    sendMessageToUserWithName: function() {
      return $('body').on('click', '.send_message_to_user', function(e) {
        var id, name;
        e.preventDefault();
        name = $(this).data('user-name');
        id = $(this).data('user-id');
        $('#search_friends_field').val(name);
        return $('#send_message_id').val(id);
      });
    },
    hideModalListener: function() {
      return $('#new_message_modal').on('hidden.bs.modal', function(e) {
        $('.message_sent_success').hide();
        $('.message_form_box').show();
        $('.error').hide();
        $('#search_friends_field').val('');
        $('#search_friends_body').val('');
        return $('.messages').data('need-update', 'true');
      });
    },
    queryServerForAutocompleteNames: function() {
      var self;
      self = this;
      return $.ajax({
        url: '/users/inbox/new',
        method: 'get',
        success: self.createAutocomplete
      });
    },
    createAutocomplete: function(data) {
      return $('#search_friends_field').autocomplete({
        source: data.friends
      });
    },
    sendMessageFormListener: function() {
      var self;
      self = this;
      return $('#send_message_button').on('click', function(e) {
        e.preventDefault();
        return $.ajax({
          url: '/users/messages/send',
          method: 'post',
          data: $('#send_message_form').serialize(),
          success: self.messageResponse
        });
      });
    },
    messageResponse: function(data) {
      if (data.sent === true) {
        $('.message_sent_success').show();
        return $('.message_form_box').hide();
      } else {
        return $('.error').show();
      }
    }
  };

}).call(this);
