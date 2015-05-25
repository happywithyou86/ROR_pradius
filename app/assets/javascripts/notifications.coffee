$ ->
  notificationsController.init()

# Handles Icon Notification

notificationsController =
  init: ->
    @longpull()
    @notificationListeners()

  longpull: ->
    self = @

    pull = () ->
      $.ajax
        method: 'get',
        url: '/users/notifications/long_pull',
        success: self.updateBadge

    setInterval(pull, 15000)

  updateBadge: (data) ->
    if data.request_number > 0
      $('#request_badge').text(data.request_number)
      $('#request_badge').show()
      $('.requests').data('need-update', 'true')

    if data.message_number > 0
      $('#message_badge').text(data.message_number)
      $('#message_badge').show()
      $('.messages').data('need-update', 'true')

  notificationListeners: ->
    self = @

    $('.notify_icon').on 'click', (e) ->
      $(@).find('.notification_badge').hide()

      if $(@).data('not-type') == 'friend'

        if $('.requests').data('need-update') == 'true'
          # TODO Longpoll: hide current_request and show spinner
          self.updateDropdownContent('requests')


      if $(@).data('not-type') == 'message'
        if $('.messages').data('need-update') == 'true'
          # TODO Longpoll: hide messages and show spinner
          self.updateDropdownContent('messages')



      self.setNotificationsRead($(@).data('not-type'))

  updateDropdownContent: (type) ->
    self = @
    $.ajax
      method: 'get',
      url: '/users/notifications/update_notifications',
      data: type: type,
    .done (response) ->
      self.updateToView(response, type)

  updateToView: (responseBody, div) ->
    $('.' + div).html(responseBody)
    $('.' + div).data('need-update', 'false')


  setNotificationsRead: (type) ->
    #TODO: combine this call with the loading drop down content to save server request maybe?
    $.ajax
      method: 'patch',
      url: '/users/notifications/mark_read',
      data: notify_type: type

