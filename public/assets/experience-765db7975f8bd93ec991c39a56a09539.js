(function() {
  var experienceController;

  $(function() {
    return experienceController.init();
  });

  experienceController = {
    init: function() {
      this.formListenerPoker();
      this.formListenerCasino();
      this.presentCheckBoxListener();
      this.newExperienceListener();
      this.editExperienceListener();
      this.editExperienceFormListener();
      return this.deleteExperienceListener();
    },
    newExperienceListener: function() {
      var self;
      self = this;
      $('#new_experience_poker').on('click', function(e) {
        e.preventDefault();
        $(this).hide();
        $('#experience_form_hidden_poker').show();
        return self.pokerRoomAutocomplete();
      });
      return $('#new_experience_casino').on('click', function(e) {
        e.preventDefault();
        $(this).hide();
        $('#experience_form_hidden_casino').show();
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
      return $('.exp_room_autocomplete').autocomplete({
        source: response.poker_rooms,
        response: function(event, ui) {
          if (ui.content.length === 0) {
            $('#exp_room_url').show();
            return $('#exp_url_field').attr('required', true);
          } else {
            $('#exp_room_url').hide();
            return $('#exp_url_field').attr('required', false);
          }
        }
      });
    },
    formListenerPoker: function() {
      var self;
      self = this;
      return $('#new_experience_form_poker').on('submit', function(e) {
        var data;
        e.preventDefault();
        data = $(this).serialize();
        return self.sendToServerPoker(data);
      });
    },
    formListenerCasino: function() {
      var self;
      self = this;
      return $('#new_experience_form_casino').on('submit', function(e) {
        var data;
        e.preventDefault();
        data = $(this).serialize();
        return self.sendToServerCasino(data);
      });
    },
    presentCheckBoxListener: function() {
      return $('#experience').on('change', function(e) {
        if ($('#experience_present').prop('checked')) {
          $('#experience_end_date_3i').attr('disabled', true);
          $('#experience_end_date_2i').attr('disabled', true);
          return $('#experience_end_date_1i').attr('disabled', true);
        } else {
          $('#experience_end_date_3i').attr('disabled', false);
          $('#experience_end_date_2i').attr('disabled', false);
          return $('#experience_end_date_1i').attr('disabled', false);
        }
      });
    },
    sendToServerPoker: function(data) {
      return $.ajax({
        url: "/users/experience/create",
        method: "post",
        data: data,
        success: this.successpoker
      });
    },
    successpoker: function(response) {
      $('#experiences_container_poker').html(response);
      $('#experience_form_hidden_poker').hide();
      $('#exp_room_url_poker').hide();
      $('#exp_url_field_poker').attr('required', false);
      $('#new_experience_poker').show();
      return document.getElementById('new_experience_form_poker').reset();
    },
    sendToServerCasino: function(data) {
      return $.ajax({
        url: "/users/experience/create",
        method: "post",
        data: data,
        success: this.successcasino
      });
    },
    successcasino: function(response) {
      $('#experiences_container_casino').html(response);
      $('#experience_form_hidden_casino').hide();
      $('#exp_room_url_casino').hide();
      $('#exp_url_field_casino').attr('required', false);
      $('#new_experience_casino').show();
      return document.getElementById('new_experience_form_casino').reset();
    },
    editExperienceListener: function() {
      var self;
      self = this;
      return $('body').on('click', '.edit_experience', function(e) {
        var data, expId;
        e.preventDefault();
        expId = $(this).data('exp-id');
        $(this).closest('.experience_container').addClass('editing_' + expId);
        data = {
          expId: $(this).data('exp-id')
        };
        return self.getEditForm(data);
      });
    },
    getEditForm: function(data) {
      return $.ajax({
        url: '/users/experience/edit',
        method: 'get',
        data: data,
        success: this.editGetSuccess
      });
    },
    editGetSuccess: function(response) {
      return $('.editing_' + response.id).html(response.partial);
    },
    editExperienceFormListener: function() {
      var self;
      self = this;
      return $('#experiences_container_poker,#experiences_container_casino').on('submit', '.edit_experience_form', function(e) {
        var data;
        e.preventDefault();
        data = $(this).serialize();
        return self.sendUpdateForm(data);
      });
    },
    sendUpdateForm: function(data) {
      return $.ajax({
        url: '/users/experiences/update',
        method: 'patch',
        data: data,
        success: this.editPutSuccess
      });
    },
    editPutSuccess: function(response) {
      $('.editing_' + response.id).html(response.partial);
      return $('.editing_' + response.id).removeClass('editing_' + response.id);
    },
    deleteExperienceListener: function() {
      var self;
      self = this;
      return $('body').on('click', '.delete_experience', function(e) {
        var data;
        e.preventDefault();
        if (confirm('Are you sure you want to delete?')) {
          data = {
            expId: $(this).data('exp-id')
          };
          return self.deleteExperience(data);
        }
      });
    },
    deleteExperience: function(data) {
      return $.ajax({
        url: '/users/experiences/destroy',
        method: 'delete',
        data: data,
        success: this.deleteSuccess
      });
    },
    deleteSuccess: function(response) {
      return $('.editing_' + response.id).remove();
    }
  };

}).call(this);
