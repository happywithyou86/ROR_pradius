# Friend Search
friendBoxContainerClass = "friend_box_container" #used to count number of results
pullRightID = "contact_next_button"
pullLeftID = "contact_previous_button"
resultsPerPage = 20

$ ->
  friendSearch.init()

friendSearch =
  init: ->
    @formListener()
    @removeFriendListener()
    @checkNumberOfRequests(1)
    @checkNumberOfPreviousRequests(1)

  formListener: ->
    self = @
    $('#friend_search').on 'submit', (e) ->
      e.preventDefault()
      self.searchForFriend($(@).serialize()).done (response) ->
        if response.results == false
          self.hideButtons()
        else
          self.checkNumberOfRequests(2)
          self.checkNumberOfPreviousRequests(2)

  removeFriendListener: () ->
    self = @

    $('#main_section').on 'click', '.remove_friendship_link', (e) ->
      e.preventDefault()
      con = confirm('Are you sure you want to remove connection?')
      if con
        data =
          friend_id: $(@).data('friend-id')

        $(@).parent('.friend_box_container').remove()
        self.deleteFriend(data)

  searchForFriend: (data) ->
    $.ajax
      url: '/users/friends/search'
      method: 'get'
      data: data
      success: @displayResponse

  displayResponse: (data) ->
    if (data.results == false)
      $('.no_results').show()
      $('.search_results').hide()
    else
      $('.no_results').hide()
      $('.search_results').show()
      $('.search_results').html(data)


  deleteFriend:(data) ->
    $.ajax
      url: '/users/friends/delete'
      method: 'delete'
      data: data
      success: @successDeleteFreind

  successDeleteFreind: (data) ->
    count = parseInt($('.contacts_count').find("a").html().split("(")[1].replace(')', '')) - 1
    $('.contacts_count').find("a").text('CONTACTS (' + count  + ")");
  

  checkNumberOfRequests: (multiplyGlitch) ->
    count = 0
    $("." + friendBoxContainerClass).each ->
      count++;

    if count / multiplyGlitch < resultsPerPage
      @hideButtons()
    else
      @showButtons()
  checkNumberOfPreviousRequests: (multiplyGlitch) ->
    count = 0
    $("." + friendBoxContainerClass).each ->    
    if (count / multiplyGlitch < (resultsPerPage*2))
      @hidePreviousButtons()
    else
      @showPreviousButtons()

  hideButtons: () ->
    $("#" + pullRightID).css('display', 'none');

  showButtons: () ->
    $("#" + pullRightID).css('display', 'block');
 
  hidePreviousButtons: () ->
    $("#" + pullLeftID).css('display', 'none');

  showPreviousButtons: () ->
    $("#" + pullLeftID).css('display', 'block');

