$ ->
  mailboxListeners.init()



##############
# Listeners #
##############

mailboxListeners =
  init: () ->
    @selectAllListener()
    @deselectAllListener()
    @messageActionListeners()
    @newestSortListener()
    @showMessageContainerListener()
    @allMessagesListener()
    @forwardMessageListener()
    @trashDeleteMessageListener()
    @searchMessageListener()
    @selectDropDownMessageListener()

  selectDropDownMessageListener: ->
    $('body').on 'click', '#messages_drop .messages li.unread', (e) ->
      e.preventDefault()
      window.location.href = 'https://PokerRadius.com/users/inbox';

  selectAllListener: ->
    $('#select_all').on 'click', (e) ->
      e.preventDefault()
      $('.messages_list_container').find(':checkbox').prop('checked', true)


  deselectAllListener: ->
    $('#deselect_all').on 'click', (e) ->
      e.preventDefault()
      $('.messages_list_container').find(':checkbox').prop('checked', false)

  messageActionListeners: ->
    $('.message_action_listener').on 'click', (e) ->
      e.preventDefault()
      data = mailboxHelpers.getActionData(@)

      if data.action == 'trash'
        url = "/users/messages/move_to_trash"
        mailboxController.messageActionControl(data, url)
        mailboxView.deleteConvos($(@).data('type'))
      else if data.action == 'read'
        mailboxView.readConvos()
        url = "/users/messages/mark_all_as_read"
        mailboxController.messageActionControl(data, url)
      else if data.action == 'unread'
        mailboxView.unreadConvos()
        url = "/users/messages/mark_all_as_unread"
        mailboxController.messageActionControl(data, url)
      else if data.action == 'delete'
        url = "/users/messages/delete_convos"
        mailboxController.messageActionControl(data, url)
        mailboxView.deleteConvos($(@).data('type'))


  newestSortListener: ->
    $('#newest_sort').on 'click', (e) ->
      e.preventDefault()
      type = $(@).data('type')

      if $(@).siblings().hasClass('arrow_down')
        $(@).siblings().removeClass('arrow_down')
        $(@).siblings().addClass('arrow_up')
        sort = 'oldest'
      else
        $(@).siblings().removeClass('arrow_up')
        $(@).siblings().addClass('arrow_down')
        sort = 'newest'

      data =
        type: type
        sort: sort

      mailboxController.newestSort(data)

  showMessageContainerListener: () ->
    ###
    $('.messages_list_container').on 'click', '.show_message', (e) ->
      convoId = $(@).data('convoid')
      type = $('#all_messages').data('type')
      data =
        convoId: convoId
        type: type

      mailboxController.getMessageShowPage(data)
    ###
  allMessagesListener: () ->
    $('#all_messages').on 'click', (e) ->
      e.preventDefault()

      type = $(@).data('type')
      if $('#newest_sort').siblings().hasClass('arrow_down')
        sort = 'newest'
      else
        sort = 'oldest'

      data =
        type: type
        sort: sort

      mailboxController.newestSort(data)


  forwardMessageListener: () ->
    $('.messages_list_container').on 'click', '.forward_message', (e) ->
      e.preventDefault()
      message = $('#message_for_forward').text()
      $('#search_friends_body').val(message)


  trashDeleteMessageListener: () ->
    $('.messages_list_container').on 'click', '.message_trash_untrash_delete', (e) ->
      e.preventDefault()

      $(@).closest('.message_container').remove()

      action = $(@).data('action')

      if action == 'trash'
        url = "/users/messages/move_to_trash"
      else if action == 'delete'
        url = "/users/messages/delete_convos"
      else if action == 'untrash'
        url = "/users/messages/untrash_convos"

      convoIds = [$(@).data('convo-id')]
      data =
        action: action
        convoIds: convoIds

      mailboxController.messageActionControl(data, url)
      mailboxView.deleteConvos($(@).data('type'))


  searchMessageListener: () ->
    $('#search_messages').on 'click', (e) ->
      e.preventDefault()
      type = $(@).data('type')
      searchString = $('#message_search_field').val()
      data =
        type: type
        searchString: searchString

      mailboxController.searchMessages(data)




##############
# Controller #
##############


 mailboxController =

  messageActionControl: (data, url) ->
    $.ajax
      url: url
      method: 'put'
      data: data
      success: @successDropdownUpdate

  successDropdownUpdate: () ->
    $('.messages').data('need-update', 'true')



  newestSort: (data) ->
    $.ajax
      url: "/users/messages/newest_sort"
      method: 'get'
      data: data
      success: @success

  success: (response) ->
    $('.messages_list_container').html(response)



  getMessageShowPage: (data) ->
    $.ajax
      url: "/users/messages/show_message"
      method: 'get'
      data: data
      success: @successMessageShow

  successMessageShow: (response) ->
    $('.messages_list_container').html(response);



  searchMessages: (data) ->
    $.ajax
      url: "/users/messages/search_messages"
      method: 'get'
      data: data
      success: @successSearchMessages

  successSearchMessages: (response) ->
    $('.messages_list_container').html(response);



##############
#    View    #
##############

mailboxView =
  deleteConvos: (action) ->
    $('.messages_list_container').find(':checkbox:checked').closest('.message_container').remove()

  readConvos: () ->
    $('.messages_list_container').find(':checkbox:checked').closest('.message_container').removeClass('unread')

  unreadConvos: () ->
    $('.messages_list_container').find(':checkbox:checked').closest('.message_container').addClass('unread')







mailboxHelpers =
  getActionData: (action) ->
    convoIds = [];

    convos = $('.messages_list_container').find(':checkbox:checked')
    $.each convos, (index, checkbox) ->
      convoId = $(checkbox).data('convo-id')
      convoIds.push(convoId)

    data =
      action: $(action).data('action')
      convoIds: convoIds








