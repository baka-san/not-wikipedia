class StripeController < ApplicationController
  protect_from_forgery :except => :webhooks

  def webhooks
    begin
      event_json = JSON.parse(request.body.read)
      event_object = event_json['data']['object']
      #refer event types here https://stripe.com/docs/api#event_types
      case event_json['type']
        when 'invoice.payment_succeeded'
          # Update subscription in ActiveRecord
          # Move this to a model or service?
          customer = User.where(stripe_customer_id: event_object['customer']).first
          subscription = customer.subscription

          if subscription
            subscription.current_period_start = date.today.to_datetime.to_i
            subscription.current_period_end = date.today.to_datetime.to_i + 1.month.to_i 
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
          # Find the customer from ActiveRecord
          customer = User.where(stripe_customer_id: event_object.customer).first
          subscription = customer.subscription

          # Delete the subscription from ActiveRecord
          if subscription
            subscription.destroy
            subscription.save
          end

          # Make user's private wiki's public
          private_wikis = customer.wikis.where(private: true)
          private_wikis.update_all(private: false)


        # when 'customer.subscription.updated'
          # handle event
      end

    # Handle errors https://stripe.com/docs/api?lang=ruby#errors
    rescue Stripe::CardError => e
      # Since it's a decline, Stripe::CardError will be caught
      body = e.json_body
      err  = body[:error]

      puts "Status is: #{e.http_status}"
      puts "Type is: #{err[:type]}"
      puts "Charge ID is: #{err[:charge]}"
      # The following fields are optional
      puts "Code is: #{err[:code]}" if err[:code]
      puts "Decline code is: #{err[:decline_code]}" if err[:decline_code]
      puts "Param is: #{err[:param]}" if err[:param]
      puts "Message is: #{err[:message]}" if err[:message]
    rescue => e
      render :json => {:status => 422, :error => "Webhook call failed"}
      return
    end
    render :json => {:status => 200}
  end

end