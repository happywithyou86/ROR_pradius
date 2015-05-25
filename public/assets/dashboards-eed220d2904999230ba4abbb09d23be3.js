(function() {
  var cashLogCreateController, highlightBestHand, tournLogCreateController;

  $(function() {
    tournLogCreateController.init();
    cashLogCreateController.init();
    return highlightBestHand.init();
  });

  highlightBestHand = {
    init: function() {
      return this.newListener();
    },
    newListener: function() {
      var self;
      self = this;
      $('#dashboard_poker').on('submit', function(e) {
        return $('#highlight_best_hand_save').click();
      });
      return $('#highlight_best_hand_save').on('click', function(e) {
        var cards, type;
        e.preventDefault();
        type = $(this).data('type');
        cards = {
          card1: $('#card_select1').val(),
          card2: $('#card_select2').val(),
          card3: $('#card_select3').val(),
          card4: $('#card_select4').val(),
          card5: $('#card_select5').val()
        };
        return self.saveHighlightBestHand(cards, type);
      });
    },
    saveHighlightBestHand: function(cards, type) {
      return $.ajax({
        url: '/dashboards/highlight_best_hand',
        method: 'post',
        data: {
          cardIds: cards,
          klass: type
        },
        success: this.success
      });
    },
    success: function(response) {
      return $('#best_hand_span').html(response);
    }
  };

  tournLogCreateController = {
    init: function() {
      this.newListener();
      this.editListenerTournament();
      this.editListenerTournamentFormListener();
      return this.deleteTournamentListener();
    },
    newListener: function() {
      var self;
      self = this;
      return $('#tourn_new_save_btn').on('click', function(e) {
        var cards, data, onlineCas;
        e.preventDefault();
        if ($(this).text() === 'NEW') {
          return self.createFormField();
        } else {
          onlineCas = $('#log_type').data('type');
          data = {
            location: $('#tourn_location').val(),
            title: $('#tourn_title').val(),
            buy_in: $('#tourn_buy').val(),
            players: $('#tourn_players').val(),
            duration: $('#tourn_duration').val(),
            rank: $('#tourn_rank').val(),
            best_hand: $('#tourn_best').val(),
            win_loss: $('#tourn_win_loss').val(),
            note: $('#tourn_note').val(),
            tournaments_and_games_date: $('#tournaments_and_games_date').val()
          };
          cards = {
            card1: $('#card_select_tourn1').val(),
            card2: $('#card_select_tourn2').val(),
            card3: $('#card_select_tourn3').val(),
            card4: $('#card_select_tourn4').val(),
            card5: $('#card_select_tourn5').val()
          };
          self.sendFormToServerTournament(data, cards, onlineCas);
          $('#tourn_form_row').hide();
          $('#tourn_form_row').find('input').each(function(k, v) {
            return $(v).val('');
          });
          return $(this).text('NEW');
        }
      });
    },
    createFormField: function() {
      $('#tourn_new_save_btn').text('Save');
      return $('#tourn_form_row').show();
    },
    sendFormToServerTournament: function(data, cards, onlineCas) {
      return $.ajax({
        url: '/dashboards/tournament_log_edit',
        method: 'post',
        data: {
          tournLog: data,
          cardIds: cards,
          type: onlineCas
        },
        success: this.successcreate
      });
    },
    successcreate: function(response) {
      return $('#tourn_form_row').before(response);
    },
    editListenerTournament: function() {
      var self;
      self = this;
      return $('body').on('click', '.edit_tourn', function(e) {
        var data, editId, tournId;
        e.preventDefault();
        tournId = $(this).data('tourn-id');
        $(this).closest('tr').addClass('editing_' + tournId);
        editId = $(this).attr("id").split("edit_tourn_")[1];
        data = {
          tournId: $(this).data('tourn-id'),
          type: $('#log_type').data('type')
        };
        return self.getEditForm(data);
      });
    },
    getEditForm: function(data) {
      return $.ajax({
        url: '/dashboards/online_tournament_edit_form',
        method: 'get',
        data: data,
        success: this.editGetSuccess
      });
    },
    editGetSuccess: function(response) {
      $('.editing_' + response.id).html(response.partial);
      $('#tourn_update_btn_' + response.id).closest("td").removeClass("tournament_hidden");
      return $('#tourn_delete_btn_' + response.id).closest("td").removeClass("tournament_hidden");
    },
    editListenerTournamentFormListener: function() {
      var self;
      self = this;
      return $('body').on('click', '.new_update_btn', function(e) {
        var cards, data, onlineCas, tournId;
        e.preventDefault();
        tournId = $(this).attr("id").split("tourn_update_btn_")[1];
        $(this).closest("td").addClass("tournament_hidden");
        $('#tourn_delete_btn_' + tournId).addClass("tournament_hidden");
        if ($(this).text() === 'New') {
          return self.createFormField();
        } else {
          onlineCas = $('#log_type').data('type');
          data = {
            location: $('#tourn_location_' + tournId).val(),
            title: $('#tourn_title_' + tournId).val(),
            buy_in: $('#tourn_buy_' + tournId).val(),
            players: $('#tourn_players_' + tournId).val(),
            duration: $('#tourn_duration_' + tournId).val(),
            rank: $('#tourn_rank_' + tournId).val(),
            best_hand: $('#tourn_best_' + tournId).val(),
            win_loss: $('#tourn_win_loss_' + tournId).val(),
            note: $('#tourn_note_' + tournId).val(),
            tournaments_and_games_date: $('#tournaments_and_games_date_' + tournId).val()
          };
          cards = {
            card1: $('#card_select_tourn_edit1').val(),
            card2: $('#card_select_tourn_edit2').val(),
            card3: $('#card_select_tourn_edit3').val(),
            card4: $('#card_select_tourn_edit4').val(),
            card5: $('#card_select_tourn_edit5').val()
          };
          return self.sendFormToServerTournamentUpdate(data, cards, onlineCas, tournId);
        }
      });
    },
    createFormField: function() {
      $('#tourn_new_save_btn').text('Save');
      return $('#tourn_form_row').show();
    },
    sendFormToServerTournamentUpdate: function(data, cards, onlineCas, tournId) {
      return $.ajax({
        url: '/dashboards/tournament_log_edit',
        method: 'post',
        data: {
          tournLog: data,
          cardIds: cards,
          type: onlineCas,
          tournament_id: tournId
        },
        success: this.successCreate
      });
    },
    successCreate: function(response) {
      $('#tournament_table tr.editing_' + $(response).find("a").attr("data-tourn-id")).before(response);
      return $('#tournament_table tr.editing_' + $(response).find("a").attr("data-tourn-id")).remove();
    },
    deleteTournamentListener: function() {
      var self;
      self = this;
      return $('body').on('click', '.delete_btn', function(e) {
        var data, onlineCas, tournId;
        e.preventDefault();
        tournId = $(this).attr("id").split("tourn_delete_btn_")[1];
        onlineCas = $('#log_type').data('type');
        data = tournId;
        return self.sendDeleteDetailToServer(data, onlineCas);
      });
    },
    sendDeleteDetailToServer: function(data, onlineCas) {
      return $.ajax({
        url: '/dashboards/tournament_log_delete',
        method: 'delete',
        data: {
          tournLog: data,
          type: onlineCas
        },
        success: this.successdelete
      });
    },
    successdelete: function(response) {
      $('#tournament_table tr.editing_' + response.id).remove();
      $('#tourn_update_btn_' + response.id).addClass("tournament_hidden");
      return $('#tourn_delete_btn_' + response.id).addClass("tournament_hidden");
    }
  };

  cashLogCreateController = {
    init: function() {
      this.newListener();
      this.editListenerCashListener();
      this.editListenerCashFormListener();
      return this.deleteCashListener();
    },
    newListener: function() {
      var self;
      self = this;
      return $('#cash_new_save_btn').on('click', function(e) {
        var cards, data, onlineCas;
        e.preventDefault();
        if ($(this).text() === 'NEW') {
          return self.createFormField();
        } else {
          onlineCas = $('#log_type').data('type');
          data = {
            location: $('#cash_location').val(),
            stake: $('#cash_stake').val(),
            buy_in: $('#cash_buy').val(),
            duration: $('#cash_duration').val(),
            best_hand: $('#cash_best').val(),
            win_loss: $('#cash_win_loss').val(),
            note: $('#cash_note').val(),
            tournaments_and_games_date: $('#cash_tournaments_and_games_date').val()
          };
          cards = {
            card1: $('#card_select_cashlog1').val(),
            card2: $('#card_select_cashlog2').val(),
            card3: $('#card_select_cashlog3').val(),
            card4: $('#card_select_cashlog4').val(),
            card5: $('#card_select_cashlog5').val()
          };
          self.sendFormToServerCash(data, cards, onlineCas);
          $('#cash_form_row').hide();
          $('#cash_form_row').find('input').each(function(k, v) {
            return $(v).val('');
          });
          return $(this).text('NEW');
        }
      });
    },
    createFormField: function() {
      $('#cash_new_save_btn').text('SAVE');
      $('#cash_new_save_btn').addClass('savebtnfix');
      return $('#cash_form_row').show();
    },
    sendFormToServerCash: function(data, cards, onlineCas) {
      return $.ajax({
        url: '/dashboards/cash_log_edit',
        method: 'post',
        data: {
          cashLog: data,
          cardIds: cards,
          type: onlineCas
        },
        success: this.successnew
      });
    },
    successnew: function(response) {
      return $('#cash_form_row').before(response);
    },
    editListenerCashListener: function() {
      var self;
      self = this;
      return $('body').on('click', '.edit_cash', function(e) {
        var cashId, data;
        e.preventDefault();
        cashId = $(this).data('cash-id');
        $(this).closest('tr').addClass('editing_' + cashId);
        data = {
          cashId: $(this).data('cash-id'),
          type: $('#log_type').data('type')
        };
        return self.getEditForm(data);
      });
    },
    getEditForm: function(data) {
      return $.ajax({
        url: '/dashboards/online_cash_edit_form',
        method: 'get',
        data: data,
        success: this.editGetSuccess
      });
    },
    editGetSuccess: function(response) {
      $('.editing_' + response.id).html(response.partial);
      $('#cash_update_btn_' + response.id).closest("td").removeClass("cash_hidden");
      return $('#cash_delete_btn_' + response.id).closest("td").removeClass("cash_hidden");
    },
    editListenerCashFormListener: function() {
      var self;
      self = this;
      return $('body').on('click', '.cash_update_btn', function(e) {
        var cards, cash_game_id, data, onlineCas;
        e.preventDefault();
        cash_game_id = $(this).attr("id").split("cash_update_btn_")[1];
        onlineCas = $('#log_type').data('type');
        $(this).closest("td").addClass("cash_hidden");
        $('#cash_delete_btn_' + cash_game_id).addClass("cash_hidden");
        if ($(this).text() === 'NEW') {
          return self.createFormField();
        } else {
          onlineCas = $('#log_type').data('type');
          data = {
            location: $('#cash_location' + cash_game_id).val(),
            stake: $('#cash_stake' + cash_game_id).val(),
            buy_in: $('#cash_buy' + cash_game_id).val(),
            duration: $('#cash_duration' + cash_game_id).val(),
            best_hand: $('#cash_best' + cash_game_id).val(),
            win_loss: $('#cash_win_loss' + cash_game_id).val(),
            note: $('#cash_note' + cash_game_id).val(),
            tournaments_and_games_date: $('#tournaments_and_games_date' + cash_game_id).val()
          };
          cards = {
            card1: $('#card_select_cashlog_edit1').val(),
            card2: $('#card_select_cashlog_edit2').val(),
            card3: $('#card_select_cashlog_edit3').val(),
            card4: $('#card_select_cashlog_edit4').val(),
            card5: $('#card_select_cashlog_edit5').val()
          };
          self.sendFormToServer(data, cards, onlineCas, cash_game_id);
          $('#cash_form_row').hide();
          return $('#cash_form_row').find('input').each(function(k, v) {
            return $(v).val('');
          });
        }
      });
    },
    sendFormToServer: function(data, cards, onlineCas, cash_game_id) {
      return $.ajax({
        url: '/dashboards/cash_log_edit',
        method: 'post',
        data: {
          cashLog: data,
          cardIds: cards,
          type: onlineCas,
          cash_game_id: cash_game_id
        },
        success: this.success
      });
    },
    success: function(response) {
      $('#cash_table tr.editing_' + $(response).find("a").attr("data-cash-id")).before(response);
      return $('#cash_table tr.editing_' + $(response).find("a").attr("data-cash-id")).remove();
    },
    deleteCashListener: function() {
      var self;
      self = this;
      return $('body').on('click', '.cash_delete_btn', function(e) {
        var cashId, data, onlineCas;
        e.preventDefault();
        cashId = $(this).attr("id").split("cash_delete_btn_")[1];
        onlineCas = $('#log_type').data('type');
        data = cashId;
        return self.sendDeleteDetailToServer(data, onlineCas);
      });
    },
    sendDeleteDetailToServer: function(data, onlineCas) {
      return $.ajax({
        url: '/dashboards/cash_log_delete',
        method: 'delete',
        data: {
          cashLog: data,
          type: onlineCas
        },
        success: this.successdelete
      });
    },
    successdelete: function(response) {
      $('#cash_table tr.editing_' + response.id).remove();
      $('#cash_update_btn_' + response.id).addClass("tournament_hidden");
      return $('#cash_delete_btn_' + response.id).addClass("tournament_hidden");
    }
  };

}).call(this);
