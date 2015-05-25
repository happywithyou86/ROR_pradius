$ ->
  tournLogCreateController.init()
  cashLogCreateController.init()
  highlightBestHand.init()
  dashboardPopUp.init()


dashboardPopUp =
  init: ->
    @newListener()
  
  newListener: ->
    self = @
    $('body').on 'click', '.questionimg img', (e) ->
      $('.message_sent_modal').modal('show')


highlightBestHand =
  init: ->
    @newListener()

  newListener: ->
    self = @
    $('#dashboard_poker').on 'submit', (e) ->
      $('#highlight_best_hand_save').click();

    $('#highlight_best_hand_save').on 'click', (e) ->
      e.preventDefault()
      type = $(@).data('type')
      cards =
          card1: $('#card_select1').val()
          card2: $('#card_select2').val()
          card3: $('#card_select3').val()
          card4: $('#card_select4').val()
          card5: $('#card_select5').val()

      self.saveHighlightBestHand(cards, type)

  saveHighlightBestHand: (cards, type) ->
    $.ajax
      url: '/dashboards/highlight_best_hand'
      method: 'post'
      data: cardIds: cards, klass: type
      success: @success

  success: (response) ->
    $('#best_hand_span').html(response)




# Tournament Log create

tournLogCreateController =
  init: ->
    @newListener()
    @editListenerTournament()
    @editListenerTournamentFormListener()
    @deleteTournamentListener()


  newListener: ->
    self = @
    $('#tourn_new_save_btn').on 'click', (e) ->
      e.preventDefault()
      if $(@).text() == 'New'
        self.createFormField()
      else
        # Send Form To Server
        onlineCas = $('#log_type').data('type')
        $('#tourn_new_save_btn').removeClass('savebtnfix')
        data =
          
          location: $('#tourn_location').val()
          title: $('#tourn_title').val()
          buy_in: $('#tourn_buy').val()
          players: $('#tourn_players').val()
          duration: $('#tourn_duration').val()
          rank: $('#tourn_rank').val()
          best_hand: $('#tourn_best').val()
          win_loss: $('#tourn_win_loss').val()
          note: $('#tourn_note').val()
          tournaments_and_games_date: $('#tournaments_and_games_date').val()

        cards =
          card1: $('#card_select_tourn1').val()
          card2: $('#card_select_tourn2').val()
          card3: $('#card_select_tourn3').val()
          card4: $('#card_select_tourn4').val()
          card5: $('#card_select_tourn5').val()

        self.sendFormToServerTournament(data, cards, onlineCas)

        $('#tourn_form_row').hide()
        $('#tourn_form_row').find('input').each (k, v) ->
          $(v).val('')


        # Change text back to New
        $(@).text('New')


  createFormField: ->
    $('#tourn_new_save_btn').text('Save')
    $('#tourn_form_row').show()

  sendFormToServerTournament: (data, cards, onlineCas) ->
    $.ajax
      url: '/dashboards/tournament_log_edit'
      method: 'post'
      data: tournLog: data, cardIds: cards, type: onlineCas
      success: @successcreate

  successcreate: (response) ->
    $('#tourn_form_row').before(response)




  editListenerTournament: () ->
    self = @
    
    $('body').on 'click', '.edit_tourn', (e) ->
      e.preventDefault()
      tournId = $(this).data('tourn-id')
      $(this).closest('tr').addClass('editing_'+ tournId)
      editId = $(this).attr("id").split("edit_tourn_")[1]
     
      data =
        tournId: $(this).data('tourn-id')
        type: $('#log_type').data('type')

      self.getEditForm(data)

  getEditForm: (data) ->
    $.ajax
      url: '/dashboards/online_tournament_edit_form'
      method: 'get'
      data: data
      success: @editGetSuccess

  editGetSuccess: (response) ->
    $('.editing_' + response.id).html(response.partial)
    $('#tourn_update_btn_'+ response.id).closest("span").removeClass("tournament_hidden")
    $('#tourn_delete_btn_'+ response.id).closest("span").removeClass("tournament_hidden")




  editListenerTournamentFormListener: () ->
    self = @
    $('body').on 'click', '.new_update_btn', (e) ->
      e.preventDefault()
      tournId = $(this).attr("id").split("tourn_update_btn_")[1]
      $(this).closest("td").addClass("tournament_hidden")
      $('#tourn_delete_btn_' + tournId).addClass("tournament_hidden")
      if $(@).text() == 'New'
        self.createFormField()
      else
        # Send Form To Server
        onlineCas = $('#log_type').data('type')

        data =
         
          location: $('#tourn_location_' + tournId ).val()
          title: $('#tourn_title_' + tournId).val()
          buy_in: $('#tourn_buy_' + tournId).val()
          players: $('#tourn_players_' + tournId).val()
          duration: $('#tourn_duration_' + tournId).val()
          rank: $('#tourn_rank_' + tournId).val()
          best_hand: $('#tourn_best_' + tournId).val()
          win_loss: $('#tourn_win_loss_' + tournId).val()
          note: $('#tourn_note_' + tournId).val()
          tournaments_and_games_date: $('#tournaments_and_games_date_'+ tournId).val()
        cards =
          card1: $('#card_select_tourn_edit1').val()
          card2: $('#card_select_tourn_edit2').val()
          card3: $('#card_select_tourn_edit3').val()
          card4: $('#card_select_tourn_edit4').val()
          card5: $('#card_select_tourn_edit5').val()

        self.sendFormToServerTournamentUpdate(data, cards, onlineCas,tournId)



  createFormField: ->
    $('#tourn_new_save_btn').text('Save')
    $('#tourn_new_save_btn').addClass('savebtnfix')
    $('#tourn_form_row').show()

  sendFormToServerTournamentUpdate: (data, cards, onlineCas,tournId) ->
    $.ajax
      url: '/dashboards/tournament_log_edit'
      method: 'post'
      data: tournLog: data, cardIds: cards, type: onlineCas ,tournament_id: tournId
      success: @successCreate

  successCreate: (response) ->
    $('#tournament_table tr.editing_'+ $(response).find("a").attr("data-tourn-id")).before(response)
    $('#tournament_table tr.editing_'+ $(response).find("a").attr("data-tourn-id")).remove()






  deleteTournamentListener: () ->
    self = @
    $('body').on 'click', '.delete_btn', (e) ->
      e.preventDefault()
      tournId = $(this).attr("id").split("tourn_delete_btn_")[1]
      onlineCas = $('#log_type').data('type')

      data =
        tournId

      self.sendDeleteDetailToServer(data,onlineCas)



  sendDeleteDetailToServer: (data,onlineCas) ->
    $.ajax
      url: '/dashboards/tournament_log_delete'
      method: 'delete'
      data: tournLog: data,type: onlineCas
      success: @successdelete

   successdelete: (response) ->
     $('#tournament_table tr.editing_' + response.id).remove()
     $('#tourn_update_btn_' + response.id).addClass("tournament_hidden")
     $('#tourn_delete_btn_' + response.id).addClass("tournament_hidden")




# Cash Log create
cashLogCreateController =
  init: ->
    @newListener()
    @editListenerCashListener()
    @editListenerCashFormListener()
    @deleteCashListener()

  newListener: ->
    self = @
    $('#cash_new_save_btn').on 'click', (e) ->
      e.preventDefault()

      if $(@).text() == 'New'
        self.createFormField()
      else
        # Send Form To Server
        $('#cash_new_save_btn').removeClass('savebtnfix');
        onlineCas = $('#log_type').data('type')
        data =
          location: $('#cash_location').val()
          stake: $('#cash_stake').val()
          buy_in: $('#cash_buy').val()
          duration: $('#cash_duration').val()
          best_hand: $('#cash_best').val()
          win_loss: $('#cash_win_loss').val()
          note: $('#cash_note').val()
          tournaments_and_games_date: $('#cash_tournaments_and_games_date').val()


        cards =
          card1: $('#card_select_cashlog1').val()
          card2: $('#card_select_cashlog2').val()
          card3: $('#card_select_cashlog3').val()
          card4: $('#card_select_cashlog4').val()
          card5: $('#card_select_cashlog5').val()

        self.sendFormToServerCash(data, cards, onlineCas)

        # Remove form from table
        $('#cash_form_row').hide()
        $('#cash_form_row').find('input').each (k, v) ->
          $(v).val('')

        # Change text back to New
        $(@).text('New')

  createFormField: ->
    $('#cash_new_save_btn').text('SAVE');
    $('#cash_new_save_btn').addClass('savebtnfix');
    $('#cash_form_row').show()


  sendFormToServerCash: (data, cards, onlineCas) ->
    $.ajax
      url: '/dashboards/cash_log_edit'
      method: 'post'
      data: cashLog: data, cardIds: cards, type: onlineCas
      success: @successnew

  successnew: (response) ->
    $('#cash_form_row').before(response)


  editListenerCashListener: () ->
    self = @
    
    $('body').on 'click', '.edit_cash', (e) ->
      e.preventDefault()
      cashId = $(this).data('cash-id')
      $(this).closest('tr').addClass('editing_'+ cashId)
      
      data =
        cashId: $(this).data('cash-id')
        type: $('#log_type').data('type')
      self.getEditForm(data)

  getEditForm: (data) ->
    $.ajax
      url: '/dashboards/online_cash_edit_form'
      method: 'get'
      data: data
      success: @editGetSuccess

  editGetSuccess: (response) ->
    $('.editing_' + response.id).html(response.partial)
    
    $('#cash_update_btn_'+ response.id).closest("span").removeClass("cash_hidden")
    $('#cash_delete_btn_'+ response.id).closest("span").removeClass("cash_hidden")

  editListenerCashFormListener: () ->
    self = @
    $('body').on 'click', '.cash_update_btn', (e) ->
      e.preventDefault()
      cash_game_id = $(this).attr("id").split("cash_update_btn_")[1]
      onlineCas = $('#log_type').data('type')
      $(this).closest("td").addClass("cash_hidden")
      $('#cash_delete_btn_' + cash_game_id).addClass("cash_hidden")

      if $(@).text() == 'New'
        self.createFormField()
      else
        # Send Form To Server
        onlineCas = $('#log_type').data('type')

        data =
          location: $('#cash_location'  + cash_game_id).val()
          stake: $('#cash_stake'  + cash_game_id).val()
          buy_in: $('#cash_buy'  + cash_game_id).val()
          duration: $('#cash_duration'  + cash_game_id).val()
          best_hand: $('#cash_best'  + cash_game_id).val()
          win_loss: $('#cash_win_loss'  + cash_game_id).val()
          note: $('#cash_note'  + cash_game_id).val()
          tournaments_and_games_date: $('#tournaments_and_games_date' + cash_game_id).val()

        cards =
          card1: $('#card_select_cashlog_edit1').val()
          card2: $('#card_select_cashlog_edit2').val()
          card3: $('#card_select_cashlog_edit3').val()
          card4: $('#card_select_cashlog_edit4').val()
          card5: $('#card_select_cashlog_edit5').val()

        self.sendFormToServer(data, cards, onlineCas,cash_game_id)

        # Remove form from table
        $('#cash_form_row').hide()
        $('#cash_form_row').find('input').each (k, v) ->
          $(v).val('')



  sendFormToServer: (data, cards, onlineCas,cash_game_id) ->
    $.ajax
      url: '/dashboards/cash_log_edit'
      method: 'post'
      data: cashLog: data, cardIds: cards, type: onlineCas,cash_game_id: cash_game_id
      success: @success

  success: (response) ->
    $('#cash_table tr.editing_'+ $(response).find("a").attr("data-cash-id")).before(response)
    $('#cash_table tr.editing_'+ $(response).find("a").attr("data-cash-id")).remove()


  deleteCashListener: () ->
    self = @
    $('body').on 'click', '.cash_delete_btn', (e) ->
      e.preventDefault()
      cashId = $(this).attr("id").split("cash_delete_btn_")[1]
      onlineCas = $('#log_type').data('type')

      data =
        cashId

      self.sendDeleteDetailToServer(data,onlineCas)



  sendDeleteDetailToServer: (data,onlineCas) ->
    $.ajax
      url: '/dashboards/cash_log_delete'
      method: 'delete'
      data: cashLog: data,type: onlineCas
      success: @successdelete

   successdelete: (response) ->
     $('#cash_table tr.editing_' + response.id).remove()
     $('#cash_update_btn_' + response.id).addClass("tournament_hidden")
     $('#cash_delete_btn_' + response.id).addClass("tournament_hidden")





