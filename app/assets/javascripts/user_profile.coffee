$ ->
  userProfile.init()


userProfile =
  init: () ->
    @flagChangeListener()

  flagChangeListener: () ->
    $('.flags').on 'click', '.flag', (e) ->
      $('#profile-flag').attr('src', $(@).attr('src'))
      id = $(@).closest('a').data('country-id')

      $('#country_id_field').val(id)


