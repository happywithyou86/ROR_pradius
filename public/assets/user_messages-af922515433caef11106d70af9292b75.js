(function() {
  var mailboxController, mailboxHelpers, mailboxListeners, mailboxView;

  $(function() {
    return mailboxListeners.init();
  });

  mailboxListeners = {
    init: function() {
      this.selectAllListener();
      this.deselectAllListener();
      this.messageActionListeners();
      this.newestSortListener();
      this.showMessageContainerListener();
      this.allMessagesListener();
      this.forwardMessageListener();
      this.trashDeleteMessageListener();
      this.searchMessageListener();
      return this.selectDropDownMessageListener();
    },
    selectDropDownMessageListener: function() {
      return $('body').on('click', '#messages_drop .messages li.unread', function(e) {
        e.preventDefault();
        return window.location.href = 'https://pradius.herokuapp.com/users/inbox';
      });
    },
    selectAllListener: function() {
      return $('#select_all').on('click', function(e) {
        e.preventDefault();
        return $('.messages_list_container').find(':checkbox').prop('checked', true);
      });
    },
    deselectAllListener: function() {
      return $('#deselect_all').on('click', function(e) {
        e.preventDefault();
        return $('.messages_list_container').find(':checkbox').prop('checked', false);
      });
    },
    messageActionListeners: function() {
      return $('.message_action_listener').on('click', function(e) {
        var data, url;
        e.preventDefault();
        if ($('#message_show_container').data('message-id') !== null) {
          data = {
            action: $(this).data('action'),
            convoIds: [$('#message_show_container').data('message-id')]
          };
        } else {
          data = mailboxHelpers.getActionData(this);
        }
        if (data.action === 'trash') {
          url = "/users/messages/move_to_trash";
          mailboxController.messageActionControl(data, url);
          return mailboxView.deleteConvos($(this).data('type'));
        } else if (data.action === 'read') {
          mailboxView.readConvos();
          url = "/users/messages/mark_all_as_read";
          return mailboxController.messageActionControl(data, url);
        } else if (data.action === 'unread') {
          mailboxView.unreadConvos();
          url = "/users/messages/mark_all_as_unread";
          return mailboxController.messageActionControl(data, url);
        } else if (data.action === 'delete') {
          url = "/users/messages/delete_convos";
          mailboxController.messageActionControl(data, url);
          return mailboxView.deleteConvos($(this).data('type'));
        }
      });
    },
    newestSortListener: function() {
      return $('#newest_sort').on('click', function(e) {
        var data, sort, type;
        e.preventDefault();
        type = $(this).data('type');
        if ($(this).siblings().hasClass('arrow_down')) {
          $(this).siblings().removeClass('arrow_down');
          $(this).siblings().addClass('arrow_up');
          sort = 'oldest';
        } else {
          $(this).siblings().removeClass('arrow_up');
          $(this).siblings().addClass('arrow_down');
          sort = 'newest';
        }
        data = {
          type: type,
          sort: sort
        };
        return mailboxController.newestSort(data);
      });
    },
    showMessageContainerListener: function() {
      return $('.messages_list_container').on('click', '.show_message', function(e) {
        var convoId, data, type;
        convoId = $(this).data('convoid');
        type = $('#all_messages').data('type');
        data = {
          convoId: convoId,
          type: type
        };
        return mailboxController.getMessageShowPage(data);
      });
    },
    allMessagesListener: function() {
      return $('#all_messages').on('click', function(e) {
        var data, sort, type;
        e.preventDefault();
        type = $(this).data('type');
        if ($('#newest_sort').siblings().hasClass('arrow_down')) {
          sort = 'newest';
        } else {
          sort = 'oldest';
        }
        data = {
          type: type,
          sort: sort
        };
        return mailboxController.newestSort(data);
      });
    },
    forwardMessageListener: function() {
      return $('.messages_list_container').on('click', '.forward_message', function(e) {
        var message;
        e.preventDefault();
        message = $('#message_for_forward').text();
        return $('#search_friends_body').val(message);
      });
    },
    trashDeleteMessageListener: function() {
      return $('.messages_list_container').on('click', '.message_trash_untrash_delete', function(e) {
        var action, convoIds, data, url;
        e.preventDefault();
        $(this).closest('.message_container').remove();
        action = $(this).data('action');
        if (action === 'trash') {
          url = "/users/messages/move_to_trash";
        } else if (action === 'delete') {
          url = "/users/messages/delete_convos";
        } else if (action === 'untrash') {
          url = "/users/messages/untrash_convos";
        }
        convoIds = [$(this).data('convo-id')];
        data = {
          action: action,
          convoIds: convoIds
        };
        mailboxController.messageActionControl(data, url);
        return mailboxView.deleteConvos($(this).data('type'));
      });
    },
    searchMessageListener: function() {
      return $('#search_messages').on('click', function(e) {
        var data, searchString, type;
        e.preventDefault();
        type = $(this).data('type');
        searchString = $('#message_search_field').val();
        data = {
          type: type,
          searchString: searchString
        };
        return mailboxController.searchMessages(data);
      });
    }
  };

  mailboxController = {
    messageActionControl: function(data, url) {
      return $.ajax({
        url: url,
        method: 'put',
        data: data,
        success: this.successDropdownUpdate
      });
    },
    successDropdownUpdate: function() {
      return $('.messages').data('need-update', 'true');
    },
    newestSort: function(data) {
      return $.ajax({
        url: "/users/messages/newest_sort",
        method: 'get',
        data: data,
        success: this.success
      });
    },
    success: function(response) {
      return $('.messages_list_container').html(response);
    },
    getMessageShowPage: function(data) {
      return $.ajax({
        url: "/users/messages/show_message",
        method: 'get',
        data: data,
        success: this.successMessageShow
      });
    },
    successMessageShow: function(response) {
      return $('.messages_list_container').html(response);
    },
    searchMessages: function(data) {
      return $.ajax({
        url: "/users/messages/search_messages",
        method: 'get',
        data: data,
        success: this.successSearchMessages
      });
    },
    successSearchMessages: function(response) {
      return $('.messages_list_container').html(response);
    }
  };

  mailboxView = {
    deleteConvos: function(action) {
      var data, sort;
      if ($('#message_show_container').data('message-id') !== null) {
        if ($('#newest_sort').siblings().hasClass('arrow_down')) {
          sort = 'newest';
        } else {
          sort = 'oldest';
        }
        data = {
          type: action,
          sort: sort
        };
        return mailboxController.newestSort(data);
      } else {
        return $('.messages_list_container').find(':checkbox:checked').closest('.message_container').remove();
      }
    },
    readConvos: function() {
      return $('.messages_list_container').find(':checkbox:checked').closest('.message_container').removeClass('unread');
    },
    unreadConvos: function() {
      return $('.messages_list_container').find(':checkbox:checked').closest('.message_container').addClass('unread');
    }
  };

  mailboxHelpers = {
    getActionData: function(action) {
      var convoIds, convos, data;
      convoIds = [];
      convos = $('.messages_list_container').find(':checkbox:checked');
      $.each(convos, function(index, checkbox) {
        var convoId;
        convoId = $(checkbox).data('convo-id');
        return convoIds.push(convoId);
      });
      return data = {
        action: $(action).data('action'),
        convoIds: convoIds
      };
    }
  };

}).call(this);
