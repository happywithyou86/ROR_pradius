(function() {
  var recommendationsController, recommendationsListeners;

  $(function() {
    return recommendationsListeners.init();
  });

  recommendationsListeners = {
    init: function() {
      this.newButtonListener();
      this.newformListenerOnline();
      this.newformListenerCasino();
      this.newStarsListenerOnline();
      this.newStarsListenerCasino();
      this.editButtonListener();
      this.editStarsListener();
      this.editFormListener();
      return this.deleteButtonListener();
    },
    newButtonListener: function() {
      var self;
      self = this;
      $('#new_recommendation_online').on('click', function(e) {
        e.preventDefault();
        $(this).hide();
        $('#recommenation_form_hidden_online').show();
        return self.pokerRoomAutocomplete();
      });
      return $('#new_recommendation_casino').on('click', function(e) {
        e.preventDefault();
        $(this).hide();
        $('#recommenation_form_hidden_casino').show();
        return self.pokerRoomAutocomplete();
      });
    },
    pokerRoomAutocomplete: function() {
      return $.ajax({
        url: '/users/experiences/autocomplete',
        method: 'get',
        success: this.activateAutoComplete
      });
    },
    activateAutoComplete: function(response) {
      return $('.rec_room_autocomplete').autocomplete({
        source: response.poker_rooms,
        response: function(event, ui) {
          if (ui.content.length === 0) {
            $('#rec_room_url').show();
            return $('#rec_url_field').attr('required', true);
          } else {
            $('#rec_room_url').hide();
            return $('#rec_url_field').attr('required', false);
          }
        }
      });
    },
    newformListenerOnline: function() {
      return $("#recommendation_form_online").on('submit', function(e) {
        var data;
        e.preventDefault();
        data = $(this).serialize();
        return recommendationsController.newPostRecommendationOnline(data);
      });
    },
    newformListenerCasino: function() {
      return $("#recommendation_form_casino").on('submit', function(e) {
        var data;
        e.preventDefault();
        data = $(this).serialize();
        return recommendationsController.newPostRecommendationCasino(data);
      });
    },
    newStarsListenerOnline: function() {
      return $("#new_recommendation_stars_online").raty({
        path: '/assets',
        score: 0,
        click: function(score, evt) {
          return $('#new_recommendation_rating_online').val(score);
        }
      });
    },
    newStarsListenerCasino: function() {
      return $("#new_recommendation_stars_casino").raty({
        path: '/assets',
        score: 0,
        click: function(score, evt) {
          return $('#new_recommendation_rating_casino').val(score);
        }
      });
    },
    editButtonListener: function() {
      return $("body").on('click', '.edit_recommentation', function(e) {
        var data, recId;
        e.preventDefault();
        recId = $(this).data('rec-id');
        $(this).closest('.each_recommendation').addClass('rec_edditing_' + recId);
        data = {
          rec_id: recId
        };
        return recommendationsController.editGetEditForm(data);
      });
    },
    editStarsListener: function() {
      return $(".edit_stars").raty('set', {
        click: function(score, evt) {
          return $(this).parents('form').find('.edit_recommendation_rating').val(score);
        }
      });
    },
    editFormListener: function() {
      return $('#recommendations_container_casino ,#recommendations_container_online').on('submit', '.edit_recommendation_form', function(e) {
        var data;
        e.preventDefault();
        data = $(this).serialize();
        return recommendationsController.updatePatchRecommendation(data);
      });
    },
    deleteButtonListener: function() {
      return $('#recommendations_container_online, #recommendations_container_casino').on('click', '.delete_recommendation', function(e) {
        var data;
        e.preventDefault();
        if (confirm('Are you sure you want to delete?')) {
          data = {
            rec_id: $(this).data('rec-id')
          };
          return recommendationsController.deleteRecommendation(data);
        }
      });
    }
  };

  recommendationsController = {
    newPostRecommendationOnline: function(data) {
      return $.ajax({
        url: '/users/recommendations/create',
        method: 'post',
        data: data,
        success: this.newSuccessOnline
      });
    },
    newPostRecommendationCasino: function(data) {
      return $.ajax({
        url: '/users/recommendations/create',
        method: 'post',
        data: data,
        success: this.newSuccessCasino
      });
    },
    newSuccessOnline: function(response) {
      $("#recommendations_container_online").html(response);
      $('#recommenation_form_hidden_online').hide();
      $('#new_recommendation_online').show();
      document.getElementById('recommendation_form_online').reset();
      $("#new_recommendation_stars_online").raty('set', {
        score: 0
      });
      $('#new_recommendation_rating_online').val('0');
      document.getElementById('new_recommendation_rating_online').value = '0';
      $('#rec_room_url_online').hide();
      return $('#rec_url_field_online').attr('required', false);
    },
    newSuccessCasino: function(response) {
      $("#recommendations_container_casino").html(response);
      $('#recommenation_form_hidden_casino').hide();
      $('#new_recommendation_casino').show();
      document.getElementById('recommendation_form_casino').reset();
      $("#new_recommendation_stars_casino").raty('set', {
        score: 0
      });
      $('#new_recommendation_rating_casino').val('0');
      document.getElementById('new_recommendation_rating_casino').value = '0';
      $('#rec_room_url_caisno').hide();
      return $('#rec_url_field_casino').attr('required', false);
    },
    editGetEditForm: function(data) {
      return $.ajax({
        url: '/users/recommendations/edit',
        method: 'get',
        data: data,
        success: this.editSuccess
      });
    },
    editSuccess: function(response) {
      $('.rec_edditing_' + response.rec_id).html(response.partial);
      recommendationsListeners.editStarsListener();
      return recommendationsListeners.editFormListener();
    },
    updatePatchRecommendation: function(data) {
      return $.ajax({
        url: '/users/recommendations/update',
        method: 'patch',
        data: data,
        success: this.updateSuccess
      });
    },
    updateSuccess: function(response) {
      $('.rec_edditing_' + response.rec_id).html(response.partial);
      return $('.rec_edditing_' + response.rec_id).removeClass('rec_edditing_' + response.rec_id);
    },
    deleteRecommendation: function(data) {
      return $.ajax({
        url: '/users/recommendations/destroy',
        method: 'delete',
        data: data,
        success: this.deleteSuccess
      });
    },
    deleteSuccess: function(response) {
      return $('.rec_edditing_' + response.rec_id).remove();
    }
  };

}).call(this);
