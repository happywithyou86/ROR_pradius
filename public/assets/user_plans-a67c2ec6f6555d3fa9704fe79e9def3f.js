(function() {
  var centerPleaseWait, checkAnnualPlan, checkMonthlyPlan, clearWaitingScreen, createPleaseWait, formValidated, popWaitingScreen, setUpBillingDefaultType, subscription, updateBillingCardCallback, updateBillingCardToken, validatedField;

  jQuery(function() {
    Stripe.setPublishableKey("pk_test_np99H0bPMGO3H1WWwePgWnyx");
    if (document.getElementById("payment_annual_plan") != null) {
      setUpBillingDefaultType();
      subscription.setupForm();
      createPleaseWait();
      centerPleaseWait();
      $(window).resize(function() {
        return centerPleaseWait();
      });
    }
    if (document.getElementById("billing_information_update") != null) {
      return $("#billing_information_update").click(function() {
        if (formValidated()) {
          return updateBillingCardToken();
        }
      });
    }
  });

  setUpBillingDefaultType = function() {
    var currentUrlSplit, index;
    $("#payment_annual_plan").click(function() {
      return checkAnnualPlan();
    });
    $("#payment_monthly_plan").click(function() {
      return checkMonthlyPlan();
    });
    $("#payment_back_button").click(function() {
      return window.history.back();
    });
    currentUrlSplit = document.URL.split('#');
    index = currentUrlSplit.length - 1;
    if (currentUrlSplit[index] === "annually") {
      return checkAnnualPlan();
    } else {
      return checkMonthlyPlan();
    }
  };

  checkAnnualPlan = function() {
    $(card_plan_hidden_variable).val("Annually");
    $("#payment_annual_plan").attr('checked', true);
    $("#payment_annually_container").css('opacity', '1');
    $("#payment_monthly_plan").attr('checked', false);
    return $("#payment_monthly_container").css('opacity', '0.5');
  };

  checkMonthlyPlan = function() {
    $(card_plan_hidden_variable).val("Monthly");
    $("#payment_annual_plan").attr('checked', false);
    $("#payment_annually_container").css('opacity', '0.5');
    $("#payment_monthly_plan").attr('checked', true);
    return $("#payment_monthly_container").css('opacity', '1');
  };

  updateBillingCardToken = function() {
    var card;
    card = {
      number: $('#card_number').val(),
      cvc: $('#card_code').val(),
      expMonth: $('#card_month').val(),
      expYear: $('#card_year').val(),
      name: $('#card_first_name').val() + $('#card_last_name').val(),
      address_line1: $('#card_address1').val(),
      address_line2: $('#card_address2').val(),
      address_city: $('#card_city').val(),
      address_state: $('#card_state').val(),
      address_zip: $('#card_zip').val(),
      address_country: $('#card_country').val()
    };
    return Stripe.createToken(card, updateBillingCardCallback);
  };

  updateBillingCardCallback = function(status, response) {
    if (status === 200) {
      return window.location.href = "/user_plans/update?card_token=" + response.id;
    } else {
      return alert("Error with your credit card.");
    }
  };

  subscription = {
    setupForm: function() {
      return $('#new_user_subscription').submit(function() {
        $('input[type=submit]').attr('disabled', true);
        if (formValidated()) {
          subscription.processCard();
          return false;
        } else {
          $('input[type=submit]').attr('disabled', false);
          return false;
        }
      });
    },
    processCard: function() {
      var card;
      card = {
        number: $('#card_number').val(),
        cvc: $('#card_code').val(),
        expMonth: $('#card_month').val(),
        expYear: $('#card_year').val(),
        name: $('#card_first_name').val() + $('#card_last_name').val(),
        address_line1: $('#card_address1').val(),
        address_line2: $('#card_address2').val(),
        address_city: $('#card_city').val(),
        address_state: $('#card_state').val(),
        address_zip: $('#card_zip').val(),
        address_country: $('#card_country').val()
      };
      popWaitingScreen();
      return Stripe.createToken(card, subscription.handleStripeResponse);
    },
    handleStripeResponse: function(status, response) {
      if (status === 200) {
        $('#user_subscription_stripe_card_token').val(response.id);
        return $('#new_user_subscription')[0].submit();
      } else {
        clearWaitingScreen();
        $('#main-stripe-error-javascript').text(response.error.message);
        return $('input[type=submit]').attr('disabled', false);
      }
    }
  };

  formValidated = function() {
    var validated;
    validated = true;
    if (!validatedField("#card_first_name")) {
      validated = false;
    }
    if (!validatedField("#card_last_name")) {
      validated = false;
    }
    if (!validatedField("#card_address1")) {
      validated = false;
    }
    if (!validatedField("#card_city")) {
      validated = false;
    }
    if (!validatedField("#card_state")) {
      validated = false;
    }
    if (!validatedField("#card_zip")) {
      validated = false;
    }
    if (!validatedField("#card_code")) {
      validated = false;
    }
    if (!validatedField("#card_country")) {
      validated = false;
    }
    if (!validatedField("#email")) {
      validated = false;
    }
    if (!validatedField("#card_number")) {
      validated = false;
    }
    if (!validatedField("#card_number")) {
      validated = false;
    }
    if (!validatedField("#card_code")) {
      validated = false;
    }
    if (!validatedField("#card_code")) {
      validated = false;
    }
    if (!validatedField("#card_month")) {
      validated = false;
    }
    if (!validatedField("#card_year")) {
      validated = false;
    }
    return validated;
  };

  validatedField = function(elementID) {
    if ($(elementID).val() === "") {
      $(elementID).addClass("subscription-field-required");
      return false;
    } else {
      $(elementID).removeClass("subscription-field-required");
      return true;
    }
  };

  popWaitingScreen = function() {
    document.getElementById('main_section').style.opacity = 0.5;
    return $("#payment-please-wait").show();
  };

  clearWaitingScreen = (function(_this) {
    return function() {
      document.getElementById('main_section').style.opacity = 1;
      return $("#payment-please-wait").hide();
    };
  })(this);

  createPleaseWait = (function(_this) {
    return function() {
      return $('body').append("<img id=\"payment-please-wait\" src=\"/assets/wait.gif\">");
    };
  })(this);

  centerPleaseWait = (function(_this) {
    return function() {
      var left, top;
      left = ($(window).width() / 2) - (489 / 2);
      top = ($(window).height() / 2) - (222 / 2);
      return $("#payment-please-wait").css({
        top: top,
        left: left
      });
    };
  })(this);

}).call(this);
