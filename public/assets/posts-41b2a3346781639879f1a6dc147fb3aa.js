(function() {
  var postView, postsController, postsListeners;

  $(function() {
    return postsListeners.init();
  });

  postsListeners = {
    init: function() {
      this.newPostListener();
      this.likeStatusListener();
      this.commentStatusListener();
      this.newCommentListener();
      this.loadMoreListener();
      return this.likeUserDetails();
    },
    newPostListener: function() {
      return $('#new_post_form').on('submit', function(e) {
        var data;
        e.preventDefault();
        data = $(this).serialize();
        return postsController.postNewPost(data);
      });
    },
    likeStatusListener: function() {
      return $('#results').on('click', '.like_status', function(e) {
        var data;
        e.preventDefault();
        data = {
          post_id: $(this).data('post-id')
        };
        postView.updateLikeLink($(this));
        return postsController.postLike(data);
      });
    },
    commentStatusListener: function() {
      return $('#results').on('click', '.comment_status', function(e) {
        var $el;
        e.preventDefault();
        $el = $(this).parents('.right_section').find('.comments_container');
        if ($el.hasClass('expanded')) {
          $el.slideUp();
          return $el.removeClass('expanded');
        } else {
          $el.addClass('expanded');
          return $el.slideDown();
        }
      });
    },
    likeUserDetails: function() {
      $('#results').on('mouseover', '.like_status', function(e) {
        var data;
        e.preventDefault();
        data = {
          post_id: $(this).data('post-id')
        };
        return postsController.userLists(data);
      });
      $('#results').on('mouseleave', '.like_status', function(e) {
        var post_id;
        e.preventDefault();
        post_id = $(this).data('post-id');
        return $('#user_list_' + post_id).html("");
      });
      return $('#results').on('mouseover', function(e) {
        return $('.user_list').hide();
      });
    },
    newCommentListener: function() {
      return $('#results').on('submit', '.new_comment_form', function(e) {
        var data;
        e.preventDefault();
        $(this).parent().siblings('.comment_list').addClass('adding_comment');
        data = $(this).serialize();
        return postsController.postNewComment(data);
      });
    },
    loadMoreListener: function() {
      return $('body').on('click', '.load', function(e) {
        e.preventDefault();
        return $.ajax({
          url: '/posts/index',
          method: 'get',
          data: {
            load_more: true
          },
          success: alert("Please scroll window for more result")
        });
      });
    }
  };

  postsController = {
    postNewPost: function(data) {
      return $.ajax({
        url: '/posts/create',
        method: 'post',
        data: data,
        success: this.newSuccess
      });
    },
    newSuccess: function(response) {
      document.getElementById('new_post_form').reset();
      $("#results").html(response.partial);
      return $.ajax({
        url: '/posts/index',
        method: 'get',
        data: {
          share: true
        }
      });
    },
    postLike: function(data) {
      return $.ajax({
        url: '/posts/like',
        method: 'post',
        data: data,
        success: this.likeSuccess
      });
    },
    likeSuccess: function(response) {},
    postNewComment: function(data) {
      return $.ajax({
        url: '/comments/create',
        method: 'post',
        data: data,
        success: this.newCommentSuccess
      });
    },
    newCommentSuccess: function(response) {
      $('.adding_comment').siblings().find('textarea').val('');
      $('.adding_comment').append(response);
      postView.updateCommentLink($('.adding_comment'));
      return $('.adding_comment').removeClass('adding_comment');
    },
    userLists: function(data) {
      return $.ajax({
        url: '/posts/user_lists',
        method: 'get',
        data: data,
        success: this.show_user_lists
      });
    },
    show_user_lists: function(response) {
      return $('#user_list_' + response.id).html(response.partial);
    }
  };

  postView = {
    updateLikeLink: function($el) {
      var likes, newLikes;
      likes = $el.data('likes');
      if ($el.data('liked')) {
        newLikes = parseInt(likes) - 1;
        $el.data('liked', false);
        $el.data('likes', newLikes);
        return $el.html('Like (' + newLikes + ')');
      } else {
        newLikes = parseInt(likes) + 1;
        $el.data('liked', true);
        $el.data('likes', newLikes);
        return $el.html('Unlike (' + newLikes + ')');
      }
    },
    updateCommentLink: function($el) {
      var $link, comments, new_comments;
      window.blah = $el;
      $link = $el.parents('.right_section').find('.comment_status');
      comments = $link.data('comments');
      new_comments = parseInt(comments) + 1;
      $link.data('comments', new_comments);
      return $link.html('Comments (' + new_comments + ')');
    }
  };

}).call(this);
