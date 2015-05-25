(function() {
  var newFriendRequestController;

  $(function() {
    return newFriendRequestController.init();
  });

  newFriendRequestController = {
    init: function() {
      return this.requestSuccess();
    },
    requestSuccess: function() {
      return $('form#friend_request_form').bind('ajax:success', function(evt, data, status, xhr) {
        $("#friend_request_modal_body").html('<button type="button" data-dismiss="modal" class="close" aria-hidden="true">&times;</button><h1 class="text-center">Request Sent</h1>');
        $('#add-as-friend').removeClass('btn-success');
        $('#add-as-friend').removeClass('friend_request_button');
        $('#add-as-friend').addClass('btn-success');
        $('#add-as-friend').text('Request Sent');
        return $('#add-as-friend').attr('disabled', true);
      });
    }
  };

}).call(this);
