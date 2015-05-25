$ ->
  postsListeners.init()





postsListeners =
  init: () ->
    @newPostListener()
    @likeStatusListener()
    @commentStatusListener()
    @newCommentListener()
    @loadMoreListener()
    @likeUserDetails()
   
  newPostListener: () ->
    $('#new_post_form').on 'submit', (e) ->
      e.preventDefault()
      formData = new FormData($('#new_post_form')[0])
      postsController.postNewPost(formData)

  likeStatusListener: () ->
    $('#results').on 'click', '.like_status', (e) ->
      e.preventDefault()
      data =
        post_id: $(@).data('post-id')

      postView.updateLikeLink($(@))
      postsController.postLike(data)

  commentStatusListener: () ->
    $('#results').on 'click', '.comment_status', (e) ->
      e.preventDefault()

      $el = $(@).parents('.right_section').find('.comments_container')
      if $el.hasClass('expanded')
        $el.slideUp()
        $el.removeClass('expanded')
      else
        $el.addClass('expanded')
        $el.slideDown()

  likeUserDetails: () ->
      $('#results').on 'mouseover', '.like_status', (e) ->
        e.preventDefault()
        data =
        post_id: $(@).data('post-id')

        postsController.userLists(data)


      $('#results').on 'mouseleave', '.like_status', (e) ->
        e.preventDefault()
        post_id = $(@).data('post-id')
        $('#user_list_' + post_id).html("")
      
      $('#results').on 'mouseover', (e) ->
        $('.user_list').hide()





  newCommentListener: () ->
    $('#results').on 'submit', '.new_comment_form', (e) ->
      e.preventDefault()

      $(@).parent().siblings('.comment_list').addClass('adding_comment')

      data = $(@).serialize()
      postsController.postNewComment(data)

  loadMoreListener: () ->
    $('body').on 'click', '.load', (e) ->
      e.preventDefault()
      $.ajax
        url: '/posts/index'
        method: 'get'
        data: load_more: true
        success: alert("Please scroll window for more result")




postsController =
  postNewPost: (data) ->
    $.ajax
      url: '/posts/create'
      method: 'post'
      data: data
      cache: false
      contentType: false
      processData: false
      enctype: 'multipart/form-data'
      success: @newSuccess
   

  newSuccess: (response) ->
    document.getElementById('new_post_form').reset()
    $("#image_preview").hide()
    $("#results").html(response.partial)
    $.ajax
      url: '/posts/index'
      method: 'get'
      data: share: true

  postLike: (data) ->
    $.ajax
      url: '/posts/like'
      method: 'post'
      data: data
      success: @likeSuccess

  likeSuccess: (response) ->

  postNewComment: (data) ->
    $.ajax
      url: '/comments/create'
      method: 'post'
      data: data
      success: @newCommentSuccess

  newCommentSuccess: (response) ->
    $('.adding_comment').siblings().find('textarea').val('')
    $('.adding_comment').append(response)

    postView.updateCommentLink($('.adding_comment'))

    $('.adding_comment').removeClass('adding_comment')



  userLists: (data) ->
    $.ajax
      url: '/posts/user_lists'
      method: 'get'
      data: data
      success: @show_user_lists

  show_user_lists: (response) ->
    $('#user_list_' + response.id).html(response.partial)



postView =
  updateLikeLink: ($el) ->
    likes = $el.data('likes')

    if $el.data('liked')
      newLikes = parseInt(likes) - 1

      $el.data('liked', false)
      $el.data('likes', newLikes)
      $el.html('Like (' + newLikes + ')')

    else
      newLikes = parseInt(likes) + 1

      $el.data('liked', true)
      $el.data('likes', newLikes)
      $el.html('Unlike (' + newLikes + ')')

  updateCommentLink: ($el) ->
    window.blah = $el
    $link = $el.parents('.right_section').find('.comment_status')
    comments = $link.data('comments')
    new_comments = parseInt(comments) + 1
    $link.data('comments', new_comments)
    $link.html('Comments (' + new_comments + ')')


