$ ->
  friendRequestListeners.init()



friendRequestListeners =
  init: () ->
    @selectAllListener()
    @deselectAllListener()
    @allRequestsListener()
    @newestListener()
    @actionListener()

    @requestListeners()


  selectAllListener: ->
    $('#select_all').on 'click', (e) ->
      e.preventDefault()
      $('.requests_list_container').find(':checkbox').prop('checked', true)


  deselectAllListener: ->
    $('#deselect_all').on 'click', (e) ->
      e.preventDefault()
      $('.requests_list_container').find(':checkbox').prop('checked', false)


  allRequestsListener: ->
    $('#all_requests').on 'click', (e) ->
      e.preventDefault()

      if $('#req_newest_sort').siblings().hasClass('arrow_down')
        sort = 'newest'
      else
        sort = 'oldest'

      data =
        sort: sort

      friendRequestController.newestSort(data)

  newestListener: ->
    $('#req_newest_sort').on 'click', (e) ->
      e.preventDefault()

      if $(@).siblings().hasClass('arrow_down')
        $(@).siblings().removeClass('arrow_down')
        $(@).siblings().addClass('arrow_up')
        sort = 'oldest'
      else
        $(@).siblings().removeClass('arrow_up')
        $(@).siblings().addClass('arrow_down')
        sort = 'newest'

      data =
        sort: sort

      friendRequestController.newestSort(data)

  actionListener: ->
    $('.request_action_listener').on 'click', (e) ->
      e.preventDefault()
      data = requestHelpers.getActionData()
      type = $(@).data('action')

      $('.requests_list_container').find(':checkbox:checked').closest('.request_container').remove()

      friendRequestController.setFriendConnection(data, type)


  requestListeners: ->
    self = @

    $('body').on 'click', '.friend_action', (e) ->
      e.preventDefault()
      e.stopPropagation()

      requestId = $(@).data('request-id')
      type = $(@).data('type')

      $(@).closest('.connection_request_li').hide()
      $(@).closest('.request_container').remove()
      $('.requests').data('need-update', 'true')

      data =
        reqIds: [requestId]
      friendRequestController.setFriendConnection(data, type)




# CONTROLLER


friendRequestController =
  newestSort: (data) ->
    $.ajax
      url: "/pending_friends/requests/sort"
      method: 'get'
      data: data
      success: @sortAllSuccess

  sortAllSuccess: (response) ->
    $('.requests_list_container').html(response)


  setFriendConnection: (data, type) ->
    url =  if type == 'accept' then '/pending_friends/accept' else '/pending_friends/ignore'
    $.ajax
      method: 'post',
      url: url,
      data: data
      success: @successDropdownUpdate


  successDropdownUpdate: (response) ->
    if response.type == 'accept'
      count = parseInt($('.contacts_count').find("a").html().split("(")[1].replace(')', '')) + 1
      $('.contacts_count').find("a").text('CONTACTS (' + count  + ")");
      $('.requests').data('need-update', 'true')
      $('.carousel-inner .friends_list_container .results').html(response.partial)
    else
      $('.requests').data('need-update', 'true')

    


# HELPERS


requestHelpers =
  getActionData: () ->
    reqIds = [];

    convos = $('.requests_list_container').find(':checkbox:checked')
    $.each convos, (index, checkbox) ->
      reqId = $(checkbox).data('request-id')
      reqIds.push(reqId)

    data =
      reqIds: reqIds








