$ ->
  endorsementController.init()


endorsementController =
  init: () ->
    @formListener()
    @newButtonListener()
    @deleteListener()
  newButtonListener: () ->
    $('#new_endorsement').on 'click', (e) ->
      e.preventDefault()
      $(@).hide()
      $('#endorsement_form_container').show()

  formListener: () ->
    self = @

    $('#endorsement_form').on 'submit', (e) ->
      e.preventDefault()
      data = $(@).serialize()
      self.sendFormToServer(data)

  sendFormToServer: (data) ->
    $.ajax
      url: '/users/endorsements/create'
      method: 'post'
      data: data
      success: @success
      error: @error


  success: (response) ->
    if response["status"] == "false"
      alert("You have aleady Endorsed")
      $('#endorsement_form_container').hide()
      document.getElementById('endorsement_form').reset()
    else
      $('#endorsement_form_container').hide()
      $('#new_endorsement').show()
      $('#endorsements_container').html(response)
      document.getElementById('endorsement_form').reset()

  error: (response) ->
    alert("You have aleady Endorsed")
    $('#endorsement_form_container').hide()
    $('#new_endorsement').show()
    document.getElementById('endorsement_form').reset()


  deleteListener: () ->
    $('#endorsements_container').on 'click', '.delete_endorsement', (e) ->
      e.preventDefault()
      e.preventDefault()

      if confirm('Are you sure you want to delete?')
        data =
          ach_id: $(@).data('ach-id')
        $(@).closest('.each_endorsement_container').addClass('ach_edditing_' + $(@).data('ach-id'))
  
        endorsementsController.deleteEndorsement(data)

endorsementsController =

  deleteEndorsement: (data) ->
    $.ajax
      url: '/endorsements/destroy'
      method: 'delete'
      data: data
      success: @deleteSuccess

  deleteSuccess: (response) ->
    $('.ach_edditing_' + response.ach_id).remove()
    $('#endorsement_form_container').show()







