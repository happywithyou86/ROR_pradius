(function() {
  var friendBoxContainerClass, friendSearch, pullLeftID, pullRightID, resultsPerPage;

  friendBoxContainerClass = "friend_box_container";

  pullRightID = "contact_next_button";

  pullLeftID = "contact_previous_button";

  resultsPerPage = 20;

  $(function() {
    return friendSearch.init();
  });

  friendSearch = {
    init: function() {
      this.formListener();
      this.removeFriendListener();
      this.checkNumberOfRequests(1);
      return this.checkNumberOfPreviousRequests(1);
    },
    formListener: function() {
      var self;
      self = this;
      return $('#friend_search').on('submit', function(e) {
        e.preventDefault();
        return self.searchForFriend($(this).serialize()).done(function(response) {
          if (response.results === false) {
            return self.hideButtons();
          } else {
            self.checkNumberOfRequests(2);
            return self.checkNumberOfPreviousRequests(2);
          }
        });
      });
    },
    removeFriendListener: function() {
      var self;
      self = this;
      return $('#main_section').on('click', '.remove_friendship_link', function(e) {
        var con, data;
        e.preventDefault();
        con = confirm('Are you sure you want to remove friend?');
        if (con) {
          data = {
            friend_id: $(this).data('friend-id')
          };
          $(this).parent('.friend_box_container').remove();
          return self.deleteFriend(data);
        }
      });
    },
    searchForFriend: function(data) {
      return $.ajax({
        url: '/users/friends/search',
        method: 'get',
        data: data,
        success: this.displayResponse
      });
    },
    displayResponse: function(data) {
      if (data.results === false) {
        $('.no_results').show();
        return $('.search_results').hide();
      } else {
        $('.no_results').hide();
        $('.search_results').show();
        return $('.search_results').html(data);
      }
    },
    deleteFriend: function(data) {
      return $.ajax({
        url: '/users/friends/delete',
        method: 'delete',
        data: data,
        success: this.successDeleteFreind
      });
    },
    successDeleteFreind: function(data) {
      var count;
      count = parseInt($('.contacts_count').find("a").html().split("(")[1].replace(')', '')) - 1;
      return $('.contacts_count').find("a").text('CONTACTS (' + count + ")");
    },
    checkNumberOfRequests: function(multiplyGlitch) {
      var count;
      count = 0;
      $("." + friendBoxContainerClass).each(function() {
        return count++;
      });
      if (count / multiplyGlitch < resultsPerPage) {
        return this.hideButtons();
      } else {
        return this.showButtons();
      }
    },
    checkNumberOfPreviousRequests: function(multiplyGlitch) {
      var count;
      count = 0;
      $("." + friendBoxContainerClass).each(function() {});
      if (count / multiplyGlitch < (resultsPerPage * 2)) {
        return this.hidePreviousButtons();
      } else {
        return this.showPreviousButtons();
      }
    },
    hideButtons: function() {
      return $("#" + pullRightID).css('display', 'none');
    },
    showButtons: function() {
      return $("#" + pullRightID).css('display', 'block');
    },
    hidePreviousButtons: function() {
      return $("#" + pullLeftID).css('display', 'none');
    },
    showPreviousButtons: function() {
      return $("#" + pullLeftID).css('display', 'block');
    }
  };

}).call(this);
