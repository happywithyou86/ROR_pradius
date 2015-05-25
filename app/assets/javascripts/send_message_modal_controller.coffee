$ ->
  sendMessageModalController.init()

sendMessageModalController =
  init: ->
    @modalClickListener()
    @sendMessageFormListener()
    @hideModalListener()
    @sendMessageToUserWithName()


  # CLick Events for modal trigger, Loads autocomplete
  modalClickListener: ->
    self = @
    $('.message_modal_autocomplete').on 'click', (e) ->
      e.preventDefault()
      self.queryServerForAutocompleteNames()


  #Send Message button click on profile or contacts page or reply in mailbox
  sendMessageToUserWithName: ->
    # $('.send_message_to_user').on 'click', (e) ->
    $('body').on 'click', '.send_message_to_user', (e) ->
      e.preventDefault()
      name = $(@).data('user-name')
      id = $(@).data('user-id')
      $('#search_friends_field').val(name)
      $('#send_message_id').val(id)

  # Reset form when modal is hidden
  hideModalListener: ->
    $('#new_message_modal').on 'hidden.bs.modal', (e) ->
      $('.message_sent_success').hide()
      $('.message_form_box').show()
      $('.error').hide()
      $('#search_friends_field').val('')
      $('#search_friends_body').val('')

      # Sync message drop down with newly sent message
      $('.messages').data('need-update', 'true')


  # query server for list of friend
  queryServerForAutocompleteNames: ->
    self = @
    $.ajax
      url: '/users/inbox/new',
      method: 'get'
      success: self.createAutocomplete

  # Create the autocomple on the input field
  createAutocomplete: (data) ->
    $('#search_friends_field').autocomplete
      source: data.friends


  #Submit form to server
  sendMessageFormListener: ->
    self = @
    # $('#send_message_form').on 'submit', (e) ->
    $('#send_message_button').on 'click', (e) ->
      e.preventDefault()
      $.ajax
        url: '/users/messages/send'
        method: 'post'
        data: $('#send_message_form').serialize()
        success: self.messageResponse

  messageResponse: (data) ->
    if data.sent == true
      $('.message_sent_success').show()
      $('.message_form_box').hide()
    else
      $('.error').show()










