$ ->
  recommendationsListeners.init()



recommendationsListeners =
  init: () ->
    @newButtonListener()
    @newformListenerOnline()
    @newformListenerCasino()
    @newStarsListenerOnline()
    @newStarsListenerCasino()
    @editButtonListener()
    @editStarsListener()
    @editFormListener()

    @deleteButtonListener()


  # New
  newButtonListener: () ->
    self = @
    $('#new_recommendation_online').on 'click', (e) ->
      e.preventDefault()
      $(@).hide()
      $('#recommenation_form_hidden_online').show()
      self.pokerRoomAutocomplete()

    $('#new_recommendation_casino').on 'click', (e) ->
      e.preventDefault()
      $(@).hide()
      $('#recommenation_form_hidden_casino').show()
      self.pokerRoomAutocomplete()

  pokerRoomAutocomplete: () ->
    $.ajax
      url: '/users/experiences/autocomplete'
      method: 'get'
      success: @activateAutoComplete

  activateAutoComplete: (response) ->
    $('.rec_room_autocomplete').autocomplete
      source: response.poker_rooms
      response: (event, ui) ->
        if ui.content.length == 0
          $('#rec_room_url').show()
          $('#rec_url_field').attr('required', true)
        else
          $('#rec_room_url').hide()
          $('#rec_url_field').attr('required', false)

  newformListenerOnline: () ->
    $("#recommendation_form_online").on 'submit', (e) ->
      e.preventDefault()
      data = $(@).serialize()

      recommendationsController.newPostRecommendationOnline(data)

  newformListenerCasino: () ->
    $("#recommendation_form_casino").on 'submit', (e) ->
       e.preventDefault()
       data = $(@).serialize()
       recommendationsController.newPostRecommendationCasino(data)

  newStarsListenerOnline: () ->
    $("#new_recommendation_stars_online").raty
      path: '/assets'
      score: 0
      click: (score, evt) ->
        $('#new_recommendation_rating_online').val(score)

   newStarsListenerCasino: () ->
    $("#new_recommendation_stars_casino").raty
      path: '/assets'
      score: 0
      click: (score, evt) ->
        $('#new_recommendation_rating_casino').val(score)

  # Edit
  editButtonListener: () ->
    $("body").on 'click', '.edit_recommentation', (e) ->
      e.preventDefault()
      recId = $(@).data('rec-id')
      $(@).closest('.each_recommendation').addClass('rec_edditing_' + recId)
      data =
        rec_id: recId


      recommendationsController.editGetEditForm(data)

  editStarsListener: () ->
    $(".edit_stars").raty 'set', click: (score, evt) ->
      $(@).parents('form').find('.edit_recommendation_rating').val(score)
      # $(@).siblings('.edit_recommendation_rating').val(score)

  editFormListener: () ->
    $('#recommendations_container_casino ,#recommendations_container_online').on 'submit', '.edit_recommendation_form', (e) ->
      e.preventDefault()
      data = $(@).serialize()
      recommendationsController.updatePatchRecommendation(data)

  # Delete

  deleteButtonListener: () ->
    $('#recommendations_container_online, #recommendations_container_casino').on 'click', '.delete_recommendation', (e) ->
      e.preventDefault()
      if confirm('Are you sure you want to delete?')
        data =
          rec_id: $(@).data('rec-id')

        recommendationsController.deleteRecommendation(data)




recommendationsController =


  # New
  newPostRecommendationOnline: (data) ->
    $.ajax
      url: '/users/recommendations/create'
      method: 'post'
      data: data
      success: @newSuccessOnline

  newPostRecommendationCasino: (data) ->
    $.ajax
      url: '/users/recommendations/create'
      method: 'post'
      data: data
      success: @newSuccessCasino

  newSuccessOnline: (response) ->
    $("#recommendations_container_online").html(response)
    $('#recommenation_form_hidden_online').hide()
    $('#new_recommendation_online').show()

    document.getElementById('recommendation_form_online').reset()

    $("#new_recommendation_stars_online").raty 'set', score: 0
    $('#new_recommendation_rating_online').val('0')
    document.getElementById('new_recommendation_rating_online').value = '0'

    $('#rec_room_url_online').hide()
    $('#rec_url_field_online').attr('required', false)

  newSuccessCasino: (response) ->
    $("#recommendations_container_casino").html(response)
    $('#recommenation_form_hidden_casino').hide()
    $('#new_recommendation_casino').show()

    document.getElementById('recommendation_form_casino').reset()

    $("#new_recommendation_stars_casino").raty 'set', score: 0
    $('#new_recommendation_rating_casino').val('0')
    document.getElementById('new_recommendation_rating_casino').value = '0'

    $('#rec_room_url_caisno').hide()
    $('#rec_url_field_casino').attr('required', false)


  # Edit
  editGetEditForm: (data) ->
    $.ajax
      url: '/users/recommendations/edit'
      method: 'get'
      data: data
      success: @editSuccess

  editSuccess: (response) ->
    $('.rec_edditing_' + response.rec_id).html(response.partial)
    recommendationsListeners.editStarsListener()
    recommendationsListeners.editFormListener()

  updatePatchRecommendation: (data) ->
    $.ajax
      url: '/users/recommendations/update'
      method: 'patch'
      data: data
      success: @updateSuccess

  updateSuccess: (response) ->
    $('.rec_edditing_' + response.rec_id).html(response.partial)
    $('.rec_edditing_' + response.rec_id).removeClass('rec_edditing_' + response.rec_id)


  # Delete
  deleteRecommendation: (data) ->
    $.ajax
      url: '/users/recommendations/destroy'
      method: 'delete'
      data: data
      success: @deleteSuccess

  deleteSuccess: (response) ->
    $('.rec_edditing_' + response.rec_id).remove()



