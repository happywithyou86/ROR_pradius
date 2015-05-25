$ ->
  achievementListeners.init()


achievementListeners =
  init: () ->
    @newFormListener()
    @newAchievementListener()

    @editAchievementListener()
    @editFormListener()

    @deleteListener()


  newAchievementListener: () ->
    $('#new_achievement_poker').on 'click', (e) ->
      e.preventDefault()
      $(@).hide()
      $('#achievement_form_container_online').show()
      $('#achievement_form_container_online ,#achievement_description').val("")
    $('#new_achievement_casino').on 'click', (e) ->
      e.preventDefault()
      $(@).hide()
      $('#achievement_form_container_casino').show()
      $('#achievement_form_container_casino ,#achievement_description').val("")

  newFormListener: () ->
    $('.achievement_form').on 'submit', (e) ->
      e.preventDefault()
      data = {description: $(this).find("textarea[id=achievement_description]").val(),online_casino:$(this).parent().closest('div').attr('id').split("achievement_form_container_")[1]}
      achievementsController.createAchievement(data)

  editAchievementListener: () ->
    $('#achievements_container_poker ,#achievements_container_casino').on 'click', '.edit_achievement', (e) ->
      e.preventDefault()
      achId = $(@).data('ach-id')

      $(@).closest('.each_achievement').addClass('ach_edditing_' + achId)

      data =
        ach_id: achId

      achievementsController.getEditAchievement(data)

  editFormListener: () ->
    $('#achievements_container_poker ,#achievements_container_casino').on 'submit', '.edit_achievement_form', (e) ->
      e.preventDefault()
      data = $(@).serialize()

      achievementsController.patchUpdateAchievement(data)


  deleteListener: () ->
    $('#achievements_container_poker ,#achievements_container_casino').on 'click', '.delete_achievement', (e) ->
      e.preventDefault()

      if confirm('Are you sure you want to delete?')
        data =
          ach_id: $(@).data('ach-id')

        achievementsController.deleteAchievement(data)



achievementsController =
  createAchievement: (data) ->
    if (data["online_casino"] == "online")
      $.ajax
        url: "/users/achievements/create"
        method: 'post'
        data: data
        success: @createSuccessOnline
    else
      $.ajax
        url: "/users/achievements/create"
        method: 'post'
        data: data
        success: @createSuccessCasino
    

  createSuccessOnline: (response) ->
    $('#achievement_form_container_online').hide()
    $('#new_achievement_poker').show()
    document.getElementById('achievement_form_container_online').getElementsByClassName("achievement_form").reset
    $('#achievements_container_poker').html(response)


  createSuccessCasino: (response) ->
    $('#achievement_form_container_casino').hide()
    $('#new_achievement_casino').show()
    document.getElementById('achievement_form_container_casino').getElementsByClassName("achievement_form").reset
    $('#achievements_container_casino').html(response)

  getEditAchievement: (data) ->
    $.ajax
      url: '/users/achievements/edit'
      method: 'get'
      data: data
      success: @getEditSuccess

  getEditSuccess: (response) ->
    $('.ach_edditing_' + response.ach_id).html(response.partial)

  patchUpdateAchievement: (data) ->
    $.ajax
      url: '/users/achievements/update'
      method: 'patch'
      data: data
      success: @patchUpdateSuccess

  patchUpdateSuccess: (response) ->
    $('.ach_edditing_' + response.ach_id).html(response.partial)
    $('.ach_edditing_' + response.ach_id).removeClass('ach_edditing_' + response.ach_id)


  deleteAchievement: (data) ->
    $.ajax
      url: '/users/achievements/destroy'
      method: 'delete'
      data: data
      success: @deleteSuccess

  deleteSuccess: (response) ->
    $('.ach_edditing_' + response.ach_id).remove()




