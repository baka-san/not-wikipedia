$(function() {
  var $form = $('#new_subscription');
  $form.submit(function(event) {
    // Disable the submit button to prevent repeated clicks:
    $form.find('.submit').prop('disabled', true);

    // Request a token from Stripe:
    // Stripe.card.createToken($form, stripeResponseHandler);

    Stripe.card.createToken({
      number: $('#card_number').val(),
      cvc: $('#card_cvc').val(),
      exp_month: $('#card_expiry_month').val(),
      exp_year: $('#card_expiry_year').val()
    }, stripeResponseHandler);

    // Prevent the form from being submitted:
    return false;
  });
});

function stripeResponseHandler(status, response) {

  // Grab the form:
  var $form = $('#new_subscription');

  if (response.error) { // Problem!

    // Show the errors on the form:
    $form.find('.payment-errors').text(response.error.message);
    $form.find('.submit').prop('disabled', false); // Re-enable submission

  } 
  else { // Token was created!

    // Get the token ID:
    var token = response.id;

    // Insert the token ID into the form so it gets submitted to the server:
    $form.append($('<input type="hidden" name="stripeToken">').val(token));

    // Be super safe and remove the data
    $('#card_number').remove();
    $('#card_cvc').remove();
    $('#card_expiry_month').remove();
    $('#card_expiry_year').remove();
    
    // Submit the form:
    $form.get(0).submit();
  }
};