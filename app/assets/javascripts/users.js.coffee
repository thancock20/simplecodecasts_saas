$(document).ready ->
  # form submission

  stripeResponseHandler = (status, response) ->
    # Get a reference to the form:
    f = $('#new_user')
    # Get the token from the response:
    token = response.id
    # Add the token to the form:
    f.append '<input type="hidden" name="user[stripe_card_token]" value="' + token + '" />'
    # Submit the form:
    f.get(0).submit()
    return

  Stripe.setPublishableKey $('meta[name="stripe-key"]').attr('content')
  # Watch for a form submission:
  $('#form-submit-btn').click (event) ->
    event.preventDefault()
    $('input[type=submit]').prop 'disabled', true
    error = false
    ccNum = $('#card_number').val()
    cvcNum = $('#card_code').val()
    expMonth = $('#card_month').val()
    expYear = $('#card_year').val()
    if !error
      # Get the Stripe token:
      Stripe.createToken {
        number: ccNum
        cvc: cvcNum
        exp_month: expMonth
        exp_year: expYear
      }, stripeResponseHandler
    false
  return
