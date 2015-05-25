$ ->
  inviteFriends.init()


inviteFriends =
  init: ->
    @formListener()

  formListener: ->
    self = @

    $('#invite_friends_form').bind 'ajax:success', (evt, data, status, xhr) ->
      document.getElementById("invite_friends_form").reset();
      self.success(data)

  success: (response) ->
    $('.invitation_sent').show()

    setTimeout( () ->
      $('.invitation_sent').fadeOut()
    , 3000)

