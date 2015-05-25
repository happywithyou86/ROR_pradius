(function() {
  var endorsementController, endorsementsController;

  $(function() {
    return endorsementController.init();
  });

  endorsementController = {
    init: function() {
      this.formListener();
      this.newButtonListener();
      return this.deleteListener();
    },
    newButtonListener: function() {
      return $('#new_endorsement').on('click', function(e) {
        e.preventDefault();
        $(this).hide();
        return $('#endorsement_form_container').show();
      });
    },
    formListener: function() {
      var self;
      self = this;
      return $('#endorsement_form').on('submit', function(e) {
        var data;
        e.preventDefault();
        data = $(this).serialize();
        return self.sendFormToServer(data);
      });
    },
    sendFormToServer: function(data) {
      return $.ajax({
        url: '/users/endorsements/create',
        method: 'post',
        data: data,
        success: this.success,
        error: this.error
      });
    },
    success: function(response) {
      $('#endorsement_form_container').hide();
      $('#new_endorsement').show();
      $('#endorsements_container').html(response);
      return document.getElementById('endorsement_form').reset();
    },
    error: function(response) {
      alert("You have aleady Endorsed");
      $('#endorsement_form_container').hide();
      $('#new_endorsement').show();
      return document.getElementById('endorsement_form').reset();
    },
    deleteListener: function() {
      return $('#endorsements_container').on('click', '.delete_endorsement', function(e) {
        var data;
        e.preventDefault();
        e.preventDefault();
        if (confirm('Are you sure you want to delete?')) {
          data = {
            ach_id: $(this).data('ach-id')
          };
          $(this).closest('.each_endorsement_container').addClass('ach_edditing_' + $(this).data('ach-id'));
          return endorsementsController.deleteEndorsement(data);
        }
      });
    }
  };

  endorsementsController = {
    deleteEndorsement: function(data) {
      return $.ajax({
        url: '/endorsements/destroy',
        method: 'delete',
        data: data,
        success: this.deleteSuccess
      });
    },
    deleteSuccess: function(response) {
      return $('.ach_edditing_' + response.ach_id).remove();
    }
  };

}).call(this);
