$ ->
  experienceController.init()


experienceController =
  init: () ->
    @formListenerPoker()
    @formListenerCasino()
    @presentCheckBoxListener()
    @newExperienceListener()
    @editExperienceListener()
    @editExperienceFormListener()
    @deleteExperienceListener()

    # NEW
  newExperienceListener: () ->
    self = @
    $('#new_experience_poker').on 'click', (e) ->
      e.preventDefault()
      $(@).hide()
      $('#experience_form_hidden_poker').show()
      self.pokerRoomAutocomplete()

    $('#new_experience_casino').on 'click', (e) ->
      e.preventDefault()
      $(@).hide()
      $('#experience_form_hidden_casino').show()
      self.pokerRoomAutocomplete()

  pokerRoomAutocomplete: () ->
    $.ajax
      url: '/users/experiences/autocomplete'
      method: 'get'
      success: @activateAutoComplete

  activateAutoComplete: (response) ->
    $('.exp_room_autocomplete').autocomplete
      source: response.poker_rooms
      response: (event, ui) ->
        if ui.content.length == 0
          $('#exp_room_url').show()
          $('#exp_url_field').attr('required', true)
        else
          $('#exp_room_url').hide()
          $('#exp_url_field').attr('required', false)





  formListenerPoker: () ->
    self = @
    $('#new_experience_form_poker').on 'submit', (e) ->
      e.preventDefault()
      data = $(@).serialize()

      self.sendToServerPoker(data)

  formListenerCasino: () ->
    self = @
    $('#new_experience_form_casino').on 'submit', (e) ->
      e.preventDefault()
      data = $(@).serialize()

      self.sendToServerCasino(data)



  presentCheckBoxListener: () ->
    $('#experience').on 'change', (e) ->
      if $('#experience_present').prop('checked')
        $('#experience_end_date_3i').attr('disabled', true)
        $('#experience_end_date_2i').attr('disabled', true)
        $('#experience_end_date_1i').attr('disabled', true)
      else
        $('#experience_end_date_3i').attr('disabled', false)
        $('#experience_end_date_2i').attr('disabled', false)
        $('#experience_end_date_1i').attr('disabled', false)


  sendToServerPoker: (data) ->
    $.ajax
      url: "/users/experience/create"
      method: "post"
      data: data
      success: @successpoker

  successpoker: (response) ->
    $('#experiences_container_poker').html(response)
    $('#experience_form_hidden_poker').hide()

    $('#exp_room_url_poker').hide()
    $('#exp_url_field_poker').attr('required', false)

    $('#new_experience_poker').show()
    document.getElementById('new_experience_form_poker').reset()

  sendToServerCasino: (data) ->
    $.ajax
      url: "/users/experience/create"
      method: "post"
      data: data
      success: @successcasino

  successcasino: (response) ->
    $('#experiences_container_casino').html(response)
    $('#experience_form_hidden_casino').hide()

    $('#exp_room_url_casino').hide()
    $('#exp_url_field_casino').attr('required', false)

    $('#new_experience_casino').show()
    document.getElementById('new_experience_form_casino').reset()



  # EDIT
  editExperienceListener: () ->
    self = @
    $('body').on 'click', '.edit_experience', (e) ->
      e.preventDefault()
      expId = $(@).data('exp-id')

      $(@).closest('.experience_container').addClass('editing_' + expId)

      data =
        expId: $(@).data('exp-id')

      self.getEditForm(data)

  getEditForm: (data) ->
    $.ajax
      url: '/users/experience/edit'
      method: 'get'
      data: data
      success: @editGetSuccess

  editGetSuccess: (response) ->
    $('.editing_' + response.id).html(response.partial)

  editExperienceFormListener: () ->
    self = @
    $('#experiences_container_poker,#experiences_container_casino').on 'submit', '.edit_experience_form', (e) ->
      e.preventDefault()
      data = $(@).serialize()
      self.sendUpdateForm(data)

  sendUpdateForm: (data) ->
    $.ajax
      url: '/users/experiences/update'
      method: 'patch'
      data: data
      success: @editPutSuccess

  editPutSuccess: (response) ->
    $('.editing_' + response.id).html(response.partial)
    $('.editing_' + response.id).removeClass('editing_' + response.id)


  # Delete

  deleteExperienceListener: () ->
    self = @
    $('body').on 'click', '.delete_experience', (e) ->
      e.preventDefault()
      if confirm('Are you sure you want to delete?')
        data =
          expId: $(@).data('exp-id')
        self.deleteExperience(data)

  deleteExperience: (data) ->
    $.ajax
      url: '/users/experiences/destroy'
      method: 'delete'
      data: data
      success: @deleteSuccess

  deleteSuccess: (response) ->
    $('.editing_' + response.id).remove()




