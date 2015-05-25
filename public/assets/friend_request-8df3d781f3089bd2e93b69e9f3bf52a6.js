(function() {
  var friendRequestController, friendRequestListeners, requestHelpers;

  $(function() {
    return friendRequestListeners.init();
  });

  friendRequestListeners = {
    init: function() {
      this.selectAllListener();
      this.deselectAllListener();
      this.allRequestsListener();
      this.newestListener();
      this.actionListener();
      return this.requestListeners();
    },
    selectAllListener: function() {
      return $('#select_all').on('click', function(e) {
        e.preventDefault();
        return $('.requests_list_container').find(':checkbox').prop('checked', true);
      });
    },
    deselectAllListener: function() {
      return $('#deselect_all').on('click', function(e) {
        e.preventDefault();
        return $('.requests_list_container').find(':checkbox').prop('checked', false);
      });
    },
    allRequestsListener: function() {
      return $('#all_requests').on('click', function(e) {
        var data, sort;
        e.preventDefault();
        if ($('#req_newest_sort').siblings().hasClass('arrow_down')) {
          sort = 'newest';
        } else {
          sort = 'oldest';
        }
        data = {
          sort: sort
        };
        return friendRequestController.newestSort(data);
      });
    },
    newestListener: function() {
      return $('#req_newest_sort').on('click', function(e) {
        var data, sort;
        e.preventDefault();
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
          sort: sort
        };
        return friendRequestController.newestSort(data);
      });
    },
    actionListener: function() {
      return $('.request_action_listener').on('click', function(e) {
        var data, type;
        e.preventDefault();
        data = requestHelpers.getActionData();
        type = $(this).data('action');
        $('.requests_list_container').find(':checkbox:checked').closest('.request_container').remove();
        return friendRequestController.setFriendConnection(data, type);
      });
    },
    requestListeners: function() {
      var self;
      self = this;
      return $('body').on('click', '.friend_action', function(e) {
        var data, requestId, type;
        e.preventDefault();
        e.stopPropagation();
        requestId = $(this).data('request-id');
        type = $(this).data('type');
        $(this).closest('.connection_request_li').hide();
        $(this).closest('.request_container').remove();
        $('.requests').data('need-update', 'true');
        data = {
          reqIds: [requestId]
        };
        return friendRequestController.setFriendConnection(data, type);
      });
    }
  };

  friendRequestController = {
    newestSort: function(data) {
      return $.ajax({
        url: "/pending_friends/requests/sort",
        method: 'get',
        data: data,
        success: this.sortAllSuccess
      });
    },
    sortAllSuccess: function(response) {
      return $('.requests_list_container').html(response);
    },
    setFriendConnection: function(data, type) {
      var url;
      url = type === 'accept' ? '/pending_friends/accept' : '/pending_friends/ignore';
      return $.ajax({
        method: 'post',
        url: url,
        data: data,
        success: this.successDropdownUpdate
      });
    },
    successDropdownUpdate: function(response) {
      var count;
      if (response.type === 'accept') {
        count = parseInt($('.contacts_count').find("a").html().split("(")[1].replace(')', '')) + 1;
        $('.contacts_count').find("a").text('CONTACTS (' + count + ")");
        $('.requests').data('need-update', 'true');
        return $('.carousel-inner .friends_list_container .results').html(response.partial);
      } else {
        return $('.requests').data('need-update', 'true');
      }
    }
  };

  requestHelpers = {
    getActionData: function() {
      var convos, data, reqIds;
      reqIds = [];
      convos = $('.requests_list_container').find(':checkbox:checked');
      $.each(convos, function(index, checkbox) {
        var reqId;
        reqId = $(checkbox).data('request-id');
        return reqIds.push(reqId);
      });
      return data = {
        reqIds: reqIds
      };
    }
  };

}).call(this);
