$ ->
  contactUs.init()


contactUs =
  init: ->
    @formListener()
    @completeenquiry()
    @completeforumenquiry()

  formListener: ->
    self = @
    $('#contact_us_form').on 'submit', (e) ->
      e.preventDefault()
      data = $(@).serialize()
      self.serverRequest(data)

  serverRequest: (data) ->
    self = @
    $.ajax
      url: '/static_pages/send_email'
      method: 'post'
      data: data
      success: @success,
      

  success: (response) ->
    if response["sent"] == true
      document.getElementById("contact_us_form").reset();
      $('#message_sent_modal').modal('show')
    else
      window.location.href = "/contact";



 
  completeenquiry: ->
    self = @
    $('body').on 'click', '#send_enquiry', (e) ->
      e.preventDefault()
      window.location.href = "/contact";

  completeforumenquiry: ->
    self = @
    $('body').on 'click', '#send_forum_enquiry', (e) ->
      e.preventDefault()
      window.location.reload();

 
