$ ->
  newFriendRequestController.init()

newFriendRequestController =
  init: () ->
    @requestSuccess()

  requestSuccess: ->
    $('form#friend_request_form').bind 'ajax:success', (evt, data, status, xhr) ->
      $("#friend_request_modal_body").html('<button type="button" data-dismiss="modal" class="close" aria-hidden="true">&times;</button><h1 class="text-center">Request Sent</h1>');
      $('#add-as-friend').removeClass('btn-success')
      $('#add-as-friend').removeClass('friend_request_button')
      $('#add-as-friend').addClass('btn-success')
      $('#add-as-friend').text('Request Sent')
      $('#add-as-friend').attr('disabled', true)


