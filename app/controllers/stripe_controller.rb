class StripeController < ApplicationController

  def webhooks
    begin
      event_json = JSON.parse(request.body.read)
      event_object = event_json['data']['object']
      #refer event types here https://stripe.com/docs/api#event_types
      case event_json['type']
        when 'invoice.payment_succeeded'
          # Update subscription in ActiveRecord
          # Which date is best to use?
          # Move this to a model or service?
          customer = User.where(stripe_customer_id: event_object.customer).first
          subscription = customer.subscription

          if subscription
            subscription.current_period_start = date.today.to_datetime.to_i
            # subscription.current_period_end
            subscription.current_period_end = date.today.to_datetime.to_i + 1.month.to_i 
            # subscription.current_period_start + 1.month.to_i
            subscription.save
          end

        # when 'invoice.payment_failed'
          # Downgrade user to standard in ActiveRecord
          # customer = User.where(stripe_customer_id: event_object.customer).first
          # customer.downgrade_to_standard

          # Delete the subscription from ActiveRecord

          # Send an email??

        # when 'charge.failed'
          # handle_failure_charge event_object


        when 'customer.subscription.deleted'
          customer = User.where(stripe_customer_id: event_object.customer).first
          subscription = customer.subscription

          if subscription
            subscription.destroy
            subscription.save
          end

        # when 'customer.subscription.updated'
          # handle event

      end
    rescue Exception => ex
      render :json => {:status => 422, :error => "Webhook call failed"}
      return
    end
    render :json => {:status => 200}
  end

end


