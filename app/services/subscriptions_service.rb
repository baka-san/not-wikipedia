require 'stripe'

class SubscriptionsService
  # PLAN = Plan.find_by_name('premium')

  # DEFAULT_CURRENCY = 'usd'

  def initialize(params, user)
    @user = user
    @email = params[:stripeEmail]
    @token = params[:stripeToken]
  end


  # How do I handle a user who cancels and then reactivates? Do I just call 
  # create again or something? Look up Stripe method.
  def call
    find_subscription
  end

  private

    # Why do we need attr_accessor here? Can't we just use the instance variables?
    # attr_accessor :user, :stripe_email, :stripe_token


    def find_subscription
      subscription = Subscription.find_by(user_id: @user.id)

      if subscription
        retrieve_subscription(subscription.stripe_subscription_id)
      else
        create_subscription(find_customer)
      end
    end

    def retrieve_subscription(id)
      Stripe::Subscription.retrieve(id)
    end

    def find_customer
      if @user.stripe_customer_id
        retrieve_customer(@user.stripe_customer_id)
      else
        create_customer
      end
    end

    def retrieve_customer(id)
      Stripe::Customer.retrieve(id) 
    end

    def create_customer
      # Create customer in Stripe
      customer = Stripe::Customer.create(
        email: @email,
        description: @email,

        source: @token
      )

      # Update ActiveRecord
      @user.update(stripe_customer_id: customer.id)
      customer
    end

    def create_subscription(customer)
      # Create subscription in Stripe for the current_user
      subscription = Stripe::Subscription.create(
        customer: customer.id,
        :items => [
          {
            :plan => "premium"
          },
        ]
      )

      # Update ActiveRecord
      sub = Subscription.create!(
        user_id: @user.id, 
        stripe_subscription_id: subscription.id,
        current_period_start: subscription.current_period_start,
        current_period_end: subscription.current_period_end
      )

      subscription
    end

end