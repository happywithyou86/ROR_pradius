(function() {
  var contactUs;

  $(function() {
    return contactUs.init();
  });

  contactUs = {
    init: function() {
      this.formListener();
      this.completeenquiry();
      return this.completeforumenquiry();
    },
    formListener: function() {
      var self;
      self = this;
      return $('#contact_us_form').on('submit', function(e) {
        var data;
        e.preventDefault();
        data = $(this).serialize();
        return self.serverRequest(data);
      });
    },
    serverRequest: function(data) {
      var self;
      self = this;
      return $.ajax({
        url: '/static_pages/send_email',
        method: 'post',
        data: data,
        success: this.success
      });
    },
    success: function(response) {
      if (response["sent"] === true) {
        document.getElementById("contact_us_form").reset();
        return $('#message_sent_modal').modal('show');
      } else {
        return window.location.href = "/static_pages/contact";
      }
    },
    completeenquiry: function() {
      var self;
      self = this;
      return $('body').on('click', '#send_enquiry', function(e) {
        e.preventDefault();
        return window.location.href = "/static_pages/contact";
      });
    },
    completeforumenquiry: function() {
      var self;
      self = this;
      return $('body').on('click', '#send_forum_enquiry', function(e) {
        e.preventDefault();
        return window.location.reload();
      });
    }
  };

}).call(this);
