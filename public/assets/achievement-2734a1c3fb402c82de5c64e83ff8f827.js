(function() {
  var achievementListeners, achievementsController;

  $(function() {
    return achievementListeners.init();
  });

  achievementListeners = {
    init: function() {
      this.newFormListener();
      this.newAchievementListener();
      this.editAchievementListener();
      this.editFormListener();
      return this.deleteListener();
    },
    newAchievementListener: function() {
      $('#new_achievement_poker').on('click', function(e) {
        e.preventDefault();
        $(this).hide();
        return $('#achievement_form_container_online').show();
      });
      return $('#new_achievement_casino').on('click', function(e) {
        e.preventDefault();
        $(this).hide();
        return $('#achievement_form_container_casino').show();
      });
    },
    newFormListener: function() {
      return $('.achievement_form').on('submit', function(e) {
        var data;
        e.preventDefault();
        data = {
          description: $(this).find("input[id=achievement_description]").val(),
          online_casino: $(this).parent().closest('div').attr('id').split("achievement_form_container_")[1]
        };
        return achievementsController.createAchievement(data);
      });
    },
    editAchievementListener: function() {
      return $('#achievements_container_poker ,#achievements_container_casino').on('click', '.edit_achievement', function(e) {
        var achId, data;
        e.preventDefault();
        achId = $(this).data('ach-id');
        $(this).closest('.each_achievement').addClass('ach_edditing_' + achId);
        data = {
          ach_id: achId
        };
        return achievementsController.getEditAchievement(data);
      });
    },
    editFormListener: function() {
      return $('#achievements_container_poker ,#achievements_container_casino').on('submit', '.edit_achievement_form', function(e) {
        var data;
        e.preventDefault();
        data = $(this).serialize();
        return achievementsController.patchUpdateAchievement(data);
      });
    },
    deleteListener: function() {
      return $('#achievements_container_poker ,#achievements_container_casino').on('click', '.delete_achievement', function(e) {
        var data;
        e.preventDefault();
        if (confirm('Are you sure you want to delete?')) {
          data = {
            ach_id: $(this).data('ach-id')
          };
          return achievementsController.deleteAchievement(data);
        }
      });
    }
  };

  achievementsController = {
    createAchievement: function(data) {
      if (data["online_casino"] === "online") {
        return $.ajax({
          url: "/users/achievements/create",
          method: 'post',
          data: data,
          success: this.createSuccessOnline
        });
      } else {
        return $.ajax({
          url: "/users/achievements/create",
          method: 'post',
          data: data,
          success: this.createSuccessCasino
        });
      }
    },
    createSuccessOnline: function(response) {
      $('#achievement_form_container_online').hide();
      $('#new_achievement_poker').show();
      document.getElementById('achievement_form_container_online').getElementsByClassName("achievement_form").reset;
      return $('#achievements_container_poker').html(response);
    },
    createSuccessCasino: function(response) {
      $('#achievement_form_container_casino').hide();
      $('#new_achievement_casino').show();
      document.getElementById('achievement_form_container_casino').getElementsByClassName("achievement_form").reset;
      return $('#achievements_container_casino').html(response);
    },
    getEditAchievement: function(data) {
      return $.ajax({
        url: '/users/achievements/edit',
        method: 'get',
        data: data,
        success: this.getEditSuccess
      });
    },
    getEditSuccess: function(response) {
      return $('.ach_edditing_' + response.ach_id).html(response.partial);
    },
    patchUpdateAchievement: function(data) {
      return $.ajax({
        url: '/users/achievements/update',
        method: 'patch',
        data: data,
        success: this.patchUpdateSuccess
      });
    },
    patchUpdateSuccess: function(response) {
      $('.ach_edditing_' + response.ach_id).html(response.partial);
      return $('.ach_edditing_' + response.ach_id).removeClass('ach_edditing_' + response.ach_id);
    },
    deleteAchievement: function(data) {
      return $.ajax({
        url: '/users/achievements/destroy',
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
