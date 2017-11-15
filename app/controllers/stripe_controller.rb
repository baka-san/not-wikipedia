class StripeController < ApplicationController

  def webhooks
    begin
      event_json = JSON.parse(request.body.read)
      event_object = event_json['data']['object']
      #refer event types here https://stripe.com/docs/api#event_types
      case event_json['type']
        when 'invoice.payment_succeeded'
          # handle_success_invoice event_object
          customer = User.where(stripe_customer_id: event_object.customer).first

          # Update subscription in ActiveRecord
          # Which date is best to use?
          # Move this to a model or service?
          subscription = customer.subscription
          subscription.current_period_start = subscription.current_period_end # Date.today.to_datetime
           # date.today.to_datetime.to_i
          subscription.current_period_end += 1.month.to_i  # Date.today.to_datetime + 1.month
           # subscription.current_period_start + 1.month.to_i

        when 'invoice.payment_failed'
          # handle_failure_invoice event_object

          # Downgrade user to standard in ActiveRecord
          customer = User.where(stripe_customer_id: event_object.customer).first
          customer.downgrade_to_standard

          # Send an email??

        when 'charge.failed'
          # handle_failure_charge event_object
        when 'customer.subscription.deleted'
        when 'customer.subscription.updated'
      end
    rescue Exception => ex
      render :json => {:status => 422, :error => "Webhook call failed"}
      return
    end
    render :json => {:status => 200}
  end

end


